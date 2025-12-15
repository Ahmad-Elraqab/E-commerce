#!/bin/bash

# Script to generate app icons for iOS and Android
# Make sure you have flutter_launcher_icons installed

echo "Generating app icons for iOS and Android..."

# Run flutter pub get first
flutter pub get

# Generate icons
flutter pub run flutter_launcher_icons

echo "App icons generated successfully!"
echo "Icons have been created for:"
echo "  - iOS: ios/Runner/Assets.xcassets/AppIcon.appiconset/"
echo "  - Android: android/app/src/main/res/mipmap-*/"



