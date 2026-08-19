#!/usr/bin/env python3
"""Create the next App Store version for any app, attach a processed build, set
its release notes, and (only with --submit) send it to review. --submit is the
irreversible step: it stays behind the flag so a human decides when it runs.

Everything here is idempotent: re-running finds the version and build it already
made instead of creating a second one, so it is safe to re-run after a timeout.

Auth uses an App Store Connect API key (Users and Access > Integrations >
App Store Connect API > "+"). Three values, none of them secret except the file:

  ASC_KEY_ID      the 10-char Key ID shown in the table
  ASC_ISSUER_ID   the UUID shown above the table
  ASC_KEY_PATH    path to the AuthKey_<KEYID>.p8 you downloaded

Usage:
  export ASC_KEY_ID=XXXXXXXXXX ASC_ISSUER_ID=xxxxxxxx-.... ASC_KEY_PATH=~/AuthKey_XXXXXXXXXX.p8
  python3 scripts/asc-release.py --version 1.0.1 --build 4 --notes docs/whats-new-1.0.1.txt
  python3 scripts/asc-release.py --version 1.0.1 --build 4 --notes ... --submit
"""
import argparse, json, os, sys, time, urllib.request, urllib.error

# Bundle ID comes from --bundle-id; no product identity is hardcoded here.
API = "https://api.appstoreconnect.apple.com/v1"


def token() -> str:
    try:
        import jwt  # PyJWT
    except ImportError:
        sys.exit("Missing PyJWT. Install it with:  pip3 install pyjwt cryptography")
    key_id, issuer = os.environ.get("ASC_KEY_ID"), os.environ.get("ASC_ISSUER_ID")
    path = os.path.expanduser(os.environ.get("ASC_KEY_PATH", ""))
    if not (key_id and issuer and path):
        sys.exit("Set ASC_KEY_ID, ASC_ISSUER_ID and ASC_KEY_PATH first (see the docstring).")
    if not os.path.exists(path):
        sys.exit(f"No .p8 at {path}")
    with open(path) as fh:
        secret = fh.read()
    now = int(time.time())
    return jwt.encode({"iss": issuer, "iat": now, "exp": now + 1200, "aud": "appstoreconnect-v1"},
                      secret, algorithm="ES256", headers={"kid": key_id, "typ": "JWT"})


def call(method: str, path: str, body=None, tok=None):
    url = path if path.startswith("http") else f"{API}{path}"
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(url, data=data, method=method)
    req.add_header("Authorization", f"Bearer {tok}")
    if data:
        req.add_header("Content-Type", "application/json")
    try:
        with urllib.request.urlopen(req) as r:
            raw = r.read()
            return json.loads(raw) if raw else {}
    except urllib.error.HTTPError as e:
        detail = e.read().decode()
        try:  # surface Apple's own message, which is far more useful than the status
            for err in json.loads(detail).get("errors", []):
                print(f"  ASC error: {err.get('title')} — {err.get('detail')}", file=sys.stderr)
        except Exception:
            print(detail, file=sys.stderr)
        raise SystemExit(f"{method} {path} failed with HTTP {e.code}")


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bundle-id", required=True, help='e.g. "com.example.myapp"')
    ap.add_argument("--version", required=True, help='marketing version, e.g. "1.0.1"')
    ap.add_argument("--build", required=True, help='build number, e.g. "4"')
    ap.add_argument("--notes", required=True, help="path to the What's New text")
    ap.add_argument("--submit", action="store_true",
                    help="actually send it to Apple review (otherwise stop with everything staged)")
    a = ap.parse_args()
    tok = token()
    notes = open(os.path.expanduser(a.notes)).read().strip()

    app = call("GET", f"/apps?filter[bundleId]={a.bundle_id}", tok=tok)["data"][0]
    app_id = app["id"]
    print(f"app: {app['attributes']['name']} ({app_id})")

    # The build must finish processing before it can be attached.
    build = None
    for attempt in range(40):
        hits = call("GET", f"/builds?filter[app]={app_id}&filter[version]={a.build}"
                           f"&filter[preReleaseVersion.version]={a.version}", tok=tok)["data"]
        if hits:
            build = hits[0]
            state = build["attributes"]["processingState"]
            print(f"build {a.version} ({a.build}): {state}")
            if state == "VALID":
                break
            if state in ("FAILED", "INVALID"):
                sys.exit(f"build is {state} — check App Store Connect for why")
        else:
            print(f"build {a.version} ({a.build}) not visible yet…")
        time.sleep(30)
    if not build or build["attributes"]["processingState"] != "VALID":
        sys.exit("build never became VALID — re-run this script later, it will pick up where it left off")

    # Reuse an existing editable version rather than creating a duplicate.
    versions = call("GET", f"/apps/{app_id}/appStoreVersions?filter[versionString]={a.version}",
                    tok=tok)["data"]
    if versions:
        ver = versions[0]
        print(f"version {a.version} already exists ({ver['id']})")
    else:
        ver = call("POST", "/appStoreVersions", {"data": {
            "type": "appStoreVersions",
            "attributes": {"platform": "IOS", "versionString": a.version},
            "relationships": {"app": {"data": {"type": "apps", "id": app_id}}}}}, tok=tok)["data"]
        print(f"created version {a.version} ({ver['id']})")
    ver_id = ver["id"]

    call("PATCH", f"/appStoreVersions/{ver_id}/relationships/build",
         {"data": {"type": "builds", "id": build["id"]}}, tok=tok)
    print(f"attached build {a.build}")

    for loc in call("GET", f"/appStoreVersions/{ver_id}/appStoreVersionLocalizations", tok=tok)["data"]:
        call("PATCH", f"/appStoreVersionLocalizations/{loc['id']}",
             {"data": {"type": "appStoreVersionLocalizations", "id": loc["id"],
                       "attributes": {"whatsNew": notes}}}, tok=tok)
        print(f"set release notes for {loc['attributes']['locale']}")

    if not a.submit:
        print("\nStaged and NOT submitted. Review it in App Store Connect, then re-run with --submit.")
        return

    sub = call("POST", "/reviewSubmissions", {"data": {
        "type": "reviewSubmissions", "attributes": {"platform": "IOS"},
        "relationships": {"app": {"data": {"type": "apps", "id": app_id}}}}}, tok=tok)["data"]
    call("POST", "/reviewSubmissionItems", {"data": {
        "type": "reviewSubmissionItems",
        "relationships": {
            "reviewSubmission": {"data": {"type": "reviewSubmissions", "id": sub["id"]}},
            "appStoreVersion": {"data": {"type": "appStoreVersions", "id": ver_id}}}}}, tok=tok)
    call("PATCH", f"/reviewSubmissions/{sub['id']}", {"data": {
        "type": "reviewSubmissions", "id": sub["id"], "attributes": {"submitted": True}}}, tok=tok)
    print(f"submitted {a.version} ({a.build}) for review")


if __name__ == "__main__":
    main()
