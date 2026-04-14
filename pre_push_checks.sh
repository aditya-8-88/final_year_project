#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "[ERROR] $1" >&2
  exit 1
}

if ! command -v flutter >/dev/null 2>&1; then
  fail "flutter is not installed or not in PATH. Install with: brew install --cask flutter"
fi

if ! command -v node >/dev/null 2>&1; then
  fail "node is not installed or not in PATH. Install with: brew install node@18"
fi

echo "[1/6] flutter --version"
flutter --version

echo "[2/6] flutter pub get"
flutter pub get

echo "[3/6] flutter analyze"
flutter analyze

echo "[4/6] flutter test"
flutter test

echo "[5/6] flutter build web --release"
flutter build web --release

echo "[6/6] node --check netlify/functions/chat.js"
node --check netlify/functions/chat.js

echo "All pre-push checks passed."
