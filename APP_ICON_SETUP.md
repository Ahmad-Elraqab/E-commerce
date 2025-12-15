# App Icon Setup Guide

This guide explains how to generate app icons for iOS and Android.

## Prerequisites

1. Ensure you have a source icon image (recommended: 1024x1024 pixels, PNG format)
2. The icon should be square and have a transparent or solid background
3. Place your icon image in `assets/images/` directory

## Current Configuration

The app is configured to use:
- **Source image**: `assets/images/logo-large.png` (for iOS and standard Android icons)
- **Adaptive icon foreground**: `assets/images/logo-small.png` (for Android adaptive icons)
- **Adaptive icon background**: Orange (#FF9500) - matches your taxi app theme

## Generating Icons

### Option 1: Using the Script (Recommended)

```bash
./generate_icons.sh
```

### Option 2: Manual Command

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## What Gets Generated

### iOS Icons
Icons will be generated in: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- All required sizes from 20x20 to 1024x1024
- Supports all iOS devices (iPhone, iPad)

### Android Icons
Icons will be generated in: `android/app/src/main/res/mipmap-*/`
- Multiple density folders (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
- Adaptive icon support (foreground + background)
- Launcher icons for all Android versions

## Customizing the Icon

To change the icon source or colors, edit `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/your-icon.png"  # Change this
  adaptive_icon_background: "#FF9500"  # Change background color
  adaptive_icon_foreground: "assets/images/your-foreground.png"  # Change foreground
```

## Icon Requirements

### Recommended Icon Specifications:
- **Format**: PNG
- **Size**: 1024x1024 pixels (minimum)
- **Background**: Transparent or solid color
- **Design**: Should be recognizable at small sizes (20x20 to 1024x1024)
- **Content**: Should not include text that becomes unreadable when scaled down

### For TAXIKUM App:
- Use your yellow/orange color scheme (#FF9500)
- Ensure the logo is centered and visible at all sizes
- Consider using a simplified version for smaller sizes

## Troubleshooting

1. **Icons not appearing**: 
   - Clean and rebuild: `flutter clean && flutter pub get`
   - Re-run icon generation
   - For iOS: Open Xcode and clean build folder

2. **Icon looks blurry**:
   - Ensure source image is at least 1024x1024
   - Use PNG format (not JPEG)
   - Avoid upscaling small images

3. **Adaptive icon issues**:
   - Ensure foreground image has transparent background
   - Check that background color matches your theme
   - Test on Android device/emulator

## Next Steps

After generating icons:
1. Test on both iOS and Android devices/emulators
2. Verify icons appear correctly at all sizes
3. Check adaptive icon behavior on Android (long-press to see)
4. Update version number in pubspec.yaml if needed



