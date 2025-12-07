#!/bin/bash
set -e  # Exit on any error

echo "========================================="
echo "Starting Flutter Web Build"
echo "========================================="

# Install Flutter
echo "Installing Flutter SDK..."
if [ ! -d "/opt/flutter" ]; then
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 /opt/flutter
fi

export PATH="$PATH:/opt/flutter/bin"

# Pre-download Dart SDK
echo "Downloading Dart SDK..."
flutter doctor

# Verify Flutter installation
echo "Flutter version:"
flutter --version

# Accept licenses
echo "Accepting Flutter licenses..."
yes | flutter doctor --android-licenses 2>/dev/null || true

# Get dependencies
echo "Getting Flutter dependencies..."
cd $DEPLOY_PRIME_PATH
flutter pub get

# Enable web
echo "Enabling Flutter web..."
flutter config --enable-web

# Build web app
echo "Building Flutter web app for production..."
flutter build web --release --web-renderer canvaskit

# Verify build output
echo "Verifying build output..."
if [ -d "build/web" ]; then
    echo "✓ Build successful! Files in build/web:"
    ls -la build/web/
else
    echo "✗ Build failed! Directory build/web does not exist"
    exit 1
fi

echo "========================================="
echo "Build Complete!"
echo "========================================="
