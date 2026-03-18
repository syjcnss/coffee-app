#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CONFIG="${1:-debug}"

echo "Building Coffee ($CONFIG)..."
swift build -c "$CONFIG"

BUILD_DIR=".build/$CONFIG"
APP_DIR="Coffee.app/Contents"

echo "Assembling Coffee.app..."
rm -rf Coffee.app
mkdir -p "$APP_DIR/MacOS"

cp "$BUILD_DIR/Coffee" "$APP_DIR/MacOS/Coffee"
cp "Sources/Coffee/Info.plist" "$APP_DIR/Info.plist"

echo "Code signing..."
codesign --force --sign - Coffee.app

echo "Done. Run with: open Coffee.app"
