#!/usr/bin/env python3
"""Stage an App Store version without submitting or releasing it."""

import argparse
import json
import os
from pathlib import Path
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

API = "https://api.appstoreconnect.apple.com/v1"


def create_token() -> str:
    try:
        import jwt
    except ImportError:
        raise SystemExit("Install PyJWT and cryptography in an isolated environment")

    key_id = os.environ.get("ASC_KEY_ID")
    issuer_id = os.environ.get("ASC_ISSUER_ID")
    key_path = os.environ.get("ASC_KEY_PATH")
    if not key_id or not issuer_id or not key_path:
        raise SystemExit("Set ASC_KEY_ID, ASC_ISSUER_ID, and ASC_KEY_PATH")
    path = Path(key_path).expanduser()
    if not path.is_file():
        raise SystemExit(f"ASC key file not found: {path}")
    now = int(time.time())
    return jwt.encode(
        {"iss": issuer_id, "iat": now, "exp": now + 1200, "aud": "appstoreconnect-v1"},
        path.read_text(),
        algorithm="ES256",
        headers={"kid": key_id, "typ": "JWT"},
    )


def request(token: str, method: str, path: str, payload=None):
    body = json.dumps(payload).encode() if payload is not None else None
    req = urllib.request.Request(f"{API}{path}", data=body, method=method)
    req.add_header("Authorization", f"Bearer {token}")
    if body is not None:
        req.add_header("Content-Type", "application/json")
    try:
        with urllib.request.urlopen(req, timeout=30) as response:
            raw = response.read()
            return json.loads(raw) if raw else {}
    except urllib.error.HTTPError as error:
        detail = error.read().decode(errors="replace")
        raise SystemExit(f"App Store Connect {method} {path} failed ({error.code}): {detail}")


def one(items, label):
    if len(items) != 1:
        raise SystemExit(f"Expected exactly one {label}; found {len(items)}")
    return items[0]


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bundle-id", required=True)
    parser.add_argument("--platform", default="IOS", choices=["IOS", "MAC_OS", "TV_OS", "VISION_OS"])
    parser.add_argument("--version", required=True)
    parser.add_argument("--build", required=True)
    parser.add_argument("--notes", help="optional UTF-8 What's New file for an update")
    parser.add_argument("--poll-seconds", type=int, default=30)
    parser.add_argument("--poll-attempts", type=int, default=40)
    args = parser.parse_args()

    notes = None
    if args.notes:
        notes_path = Path(args.notes).expanduser()
        if not notes_path.is_file():
            raise SystemExit(f"Release-notes file not found: {notes_path}")
        notes = notes_path.read_text().strip()
        if not notes:
            raise SystemExit("Release notes are empty")

    token = create_token()
    bundle_filter = urllib.parse.quote(args.bundle_id, safe="")
    app = one(request(token, "GET", f"/apps?filter[bundleId]={bundle_filter}").get("data", []), "app")
    app_id = app["id"]

    build = None
    for _ in range(args.poll_attempts):
        query = (
            f"/builds?filter[app]={app_id}&filter[version]={urllib.parse.quote(args.build)}"
            "&include=preReleaseVersion&limit=200"
        )
        response = request(token, "GET", query)
        prerelease_versions = {
            item["id"]: item["attributes"].get("version")
            for item in response.get("included", [])
            if item.get("type") == "preReleaseVersions"
        }
        builds = [
            item for item in response.get("data", [])
            if prerelease_versions.get(
                item.get("relationships", {}).get("preReleaseVersion", {}).get("data", {}).get("id")
            ) == args.version
        ]
        if builds:
            build = one(builds, "matching build")
            state = build["attributes"]["processingState"]
            print(f"build processing state: {state}")
            if state == "VALID":
                break
            if state in {"FAILED", "INVALID"}:
                raise SystemExit(f"Build processing ended as {state}")
        time.sleep(args.poll_seconds)
    if not build or build["attributes"]["processingState"] != "VALID":
        raise SystemExit("Build did not become VALID within the polling window")

    query = f"/apps/{app_id}/appStoreVersions?filter[platform]={args.platform}&filter[versionString]={urllib.parse.quote(args.version)}"
    versions = request(token, "GET", query).get("data", [])
    if versions:
        version = one(versions, "matching editable version")
    else:
        version = request(token, "POST", "/appStoreVersions", {"data": {
            "type": "appStoreVersions",
            "attributes": {"platform": args.platform, "versionString": args.version},
            "relationships": {"app": {"data": {"type": "apps", "id": app_id}}},
        }})["data"]

    version_id = version["id"]
    request(token, "PATCH", f"/appStoreVersions/{version_id}/relationships/build", {
        "data": {"type": "builds", "id": build["id"]}
    })

    if notes is not None:
        localizations = request(
            token, "GET", f"/appStoreVersions/{version_id}/appStoreVersionLocalizations"
        ).get("data", [])
        if not localizations:
            raise SystemExit("No version localizations exist; create metadata localizations before staging notes")
        for localization in localizations:
            localization_id = localization["id"]
            request(token, "PATCH", f"/appStoreVersionLocalizations/{localization_id}", {"data": {
                "type": "appStoreVersionLocalizations",
                "id": localization_id,
                "attributes": {"whatsNew": notes},
            }})

    print(f"Staged version {args.version} build {args.build}; not submitted and not released")


if __name__ == "__main__":
    main()
