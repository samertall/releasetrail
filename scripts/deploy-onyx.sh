#!/usr/bin/env bash
set -euo pipefail

ADDRESS="${1:-}"
KEYNAME="${2:-}"
if [[ ! "$ADDRESS" =~ ^g1[a-z0-9]{38}$ ]] || [[ -z "$KEYNAME" ]]; then
  echo "Usage: $0 <YOUR_G1_ADDRESS> <YOUR_GNOKEY_KEY_NAME>" >&2
  echo "Wallet address must have form g1... (40 characters)." >&2
  exit 2
fi
for binary in gno gnokey; do
  command -v "$binary" >/dev/null || { echo "Missing $binary: install the Gno toolchain." >&2; exit 1; }
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT
cp "$PROJECT_DIR"/realm/releasetrail.gno "$TEMP_DIR/"
cp "$PROJECT_DIR"/realm/releasetrail_test.gno "$TEMP_DIR/"
cat > "$TEMP_DIR/gnomod.toml" <<TOML
module = "gno.land/r/${ADDRESS}/releasetrail"
gno = "0.9"
TOML

cd "$TEMP_DIR"
echo "Formatting, linting and testing Gno realm..."
gno fmt ./...
gno lint ./...
gno test ./...

PKG="gno.land/r/${ADDRESS}/releasetrail"
echo "Publishing ${PKG} to Onyx testnet (chainid onyx-1)."
echo "Only sign this transaction in your own encrypted local wallet."
gnokey maketx addpkg \
  -pkgpath "$PKG" \
  -pkgdir . \
  -gas-fee 5000ugnot \
  -gas-wanted 5000000 \
  -chainid onyx-1 \
  -remote https://rpc.latest.testnets.gno.land:443 \
  "$KEYNAME"
echo "Once enabled, open https://latest.testnets.gno.land/r/${ADDRESS}/releasetrail"
