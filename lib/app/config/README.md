# App Configuration System

A comprehensive JSON-based configuration system for customizing app themes, features, navigation, and UI components.

## Overview

This configuration system allows you to:
- 🎨 **Customize Colors & Theme** - Primary, secondary, tertiary colors with light/dark variants
- 🔧 **Toggle Features** - Enable/disable features with priority levels
- 🧭 **Configure Navigation** - Customize bottom navigation items, order, and visibility
- 📐 **Control UI** - Spacing, border radius, typography, and animations
- 🏠 **Manage Home Sections** - Order and visibility of home page sections
- 🏷️ **Brand Customization** - Logo, app name, URLs, and more

## Quick Start

### 1. Configuration is automatically loaded in `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize configuration
  await AppConfigService.instance.initialize(
    configPath: 'lib/app/config/app_config.json',
  );
  
  runApp(App(env: EnvironmentConfig.dev));
}
```

### 2. Access configuration anywhere in the app:

```dart
// Get config service
final config = AppConfigService.instance;

// Access colors
final primaryColor = config.config.theme.colors.primary.main;

// Check feature flags
if (config.isFeatureEnabled('wishlist')) {
  // Show wishlist
}

// Get app info
final appName = config.appInfo.name;
```

## Configuration Structure

### `app_config.json` Main Sections:

| Section | Description |
|---------|-------------|
| `app` | App info - name, tagline, URLs |
| `branding` | Logo configuration |
| `theme` | Colors, gradients, typography |
| `features` | Feature flags with priorities |
| `navigation` | Bottom nav, app bar, drawer |
| `ui` | UI component configurations |
| `home` | Home page sections |
| `api` | API configuration |
| `localization` | Language settings |

## Theme Configuration

### Colors

Colors are organized in semantic groups:

```json
{
  "theme": {
    "colors": {
      "primary": {
        "main": "#FF9500",
        "light": "#FFB347",
        "dark": "#E68600",
        "contrast": "#FFFFFF"
      },
      "secondary": { ... },
      "tertiary": { ... },
      "accent": { ... },
      "success": { ... },
      "warning": { ... },
      "error": { ... },
      "info": { ... },
      "background": {
        "default": "#F9F9F9",
        "paper": "#FFFFFF",
        "elevated": "#FFFFFF",
        "disabled": "#EBEBEB"
      },
      "surface": { ... },
      "text": {
        "primary": "#252525",
        "secondary": "#666666",
        "disabled": "#9C9C9C",
        "hint": "#A5A5A5",
        "inverse": "#FFFFFF"
      },
      "border": { ... }
    }
  }
}
```

### Using Dynamic Colors

```dart
import 'package:taxi_client_app/app/config/dynamic_colors.dart';

// Get colors instance
final colors = DynamicColors.instance;

// Use colors
Container(
  color: colors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: colors.textPrimary),
  ),
);

// Or with extension
Container(
  color: context.colors.primary,
);
```

### Gradients

```json
{
  "gradients": {
    "primary": ["#FF9500", "#FFB347"],
    "splash": ["#FF9500", "#E68600"],
    "banner1": ["#FF6B6B", "#FF8E53"],
    "banner2": ["#4ECDC4", "#44A08D"],
    "banner3": ["#667EEA", "#764BA2"]
  }
}
```

## Feature Configuration

Features are organized by priority levels:

| Priority | Level | Description |
|----------|-------|-------------|
| 1 | Core | Essential features (auth, splash) |
| 2 | Primary | Main features (home, categories, products) |
| 3 | Secondary | Important features (cart, checkout, orders) |
| 4 | Tertiary | Additional features (profile, search) |
| 5 | Optional | Extra features (reviews, chat, loyalty) |

### Feature Flags Example

```json
{
  "features": {
    "primary": {
      "enabled": true,
      "priority": 2,
      "items": {
        "home": {
          "enabled": true,
          "showSearchBar": true,
          "showBannerCarousel": true,
          "showCategories": true,
          "showFlashDeals": true,
          "showFeaturedProducts": true
        }
      }
    }
  }
}
```

### Checking Feature Flags

```dart
final config = AppConfigService.instance;

// Simple check
if (config.isFeatureEnabled('wishlist')) {
  // Show wishlist button
}

// Get detailed config
final homeConfig = config.getHomeConfig();
if (homeConfig.showSearchBar) {
  // Show search bar
}

// Get all flags
final allFlags = config.getAllFeatureFlags();
print(allFlags); // {'home': true, 'cart': true, ...}
```

## Navigation Configuration

### Bottom Navigation

```json
{
  "navigation": {
    "bottomNav": {
      "enabled": true,
      "style": "modern",
      "showLabels": true,
      "showBadges": true,
      "items": [
        {
          "id": "home",
          "label": "Home",
          "icon": "home_outlined",
          "activeIcon": "home",
          "route": "/home",
          "enabled": true,
          "order": 1
        },
        {
          "id": "categories",
          "label": "Categories",
          "icon": "grid_view_outlined",
          "activeIcon": "grid_view",
          "route": "/categories",
          "enabled": true,
          "order": 2
        }
      ]
    }
  }
}
```

### Reordering Navigation

To change nav order, simply modify the `order` property:

```json
{
  "items": [
    { "id": "home", "order": 1 },
    { "id": "profile", "order": 2 },  // Profile now second
    { "id": "categories", "order": 3 },
    { "id": "orders", "order": 4 }
  ]
}
```

### Hiding Navigation Items

Set `enabled: false` to hide an item:

```json
{
  "id": "orders",
  "enabled": false,
  "order": 3
}
```

## UI Configuration

### Splash Screen

```json
{
  "ui": {
    "splash": {
      "backgroundColor": "primary",
      "useGradient": true,
      "showCircles": true,
      "animationType": "scale_fade"
    }
  }
}
```

### Border Radius

```json
{
  "borderRadius": {
    "none": 0,
    "small": 8,
    "medium": 12,
    "large": 16,
    "xl": 20,
    "xxl": 24,
    "full": 9999
  }
}
```

### Spacing

```json
{
  "spacing": {
    "xs": 4,
    "sm": 8,
    "md": 16,
    "lg": 24,
    "xl": 32,
    "xxl": 48
  }
}
```

## Home Page Sections

Configure which sections appear and in what order:

```json
{
  "home": {
    "sections": [
      {
        "id": "search",
        "type": "search_bar",
        "enabled": true,
        "order": 1
      },
      {
        "id": "banners",
        "type": "banner_carousel",
        "enabled": true,
        "order": 2,
        "config": {
          "autoPlay": true,
          "autoPlayInterval": 5000
        }
      },
      {
        "id": "categories",
        "type": "category_list",
        "enabled": true,
        "order": 3
      },
      {
        "id": "flash_deals",
        "type": "product_list",
        "enabled": true,
        "order": 4,
        "config": {
          "title": "Flash Deals",
          "emoji": "⚡"
        }
      }
    ]
  }
}
```

## Branding

### Logo Configuration

```json
{
  "branding": {
    "logo": {
      "small": "assets/images/logo-small.png",
      "medium": "assets/images/logo-large.png",
      "large": "assets/images/logo-extra-large.png",
      "splash": "assets/images/logo-large.png",
      "showLogoOnSplash": true,
      "showLogoOnAppBar": false,
      "logoType": "image"
    }
  }
}
```

## API Reference

### AppConfigService

```dart
// Singleton instance
AppConfigService.instance

// Initialize
await AppConfigService.instance.initialize(configPath: '...');

// Access config
final config = AppConfigService.instance.config;

// Feature checking
bool isEnabled = AppConfigService.instance.isFeatureEnabled('feature_name');

// Get specific configs
final homeConfig = AppConfigService.instance.getHomeConfig();
final authConfig = AppConfigService.instance.getAuthConfig();
final profileConfig = AppConfigService.instance.getProfileConfig();

// Theme access
final primaryColor = AppConfigService.instance.primaryColor;
final fontFamily = AppConfigService.instance.fontFamily;
```

### DynamicColors

```dart
// Singleton instance
DynamicColors.instance

// Primary colors
colors.primary
colors.primaryLight
colors.primaryDark

// Semantic colors
colors.success
colors.warning
colors.error
colors.info

// Background/Surface
colors.background
colors.surface
colors.surfaceVariant

// Text colors
colors.textPrimary
colors.textSecondary
colors.textDisabled

// Gradients
colors.primaryGradient
colors.splashGradient
```

### AppTheme

```dart
// Get theme instance
final appTheme = AppTheme();

// Get light theme
ThemeData light = appTheme.lightTheme;

// Get dark theme
ThemeData dark = appTheme.darkTheme;

// Get current theme based on config
ThemeData current = appTheme.currentTheme;
```

## File Structure

```
lib/app/config/
├── app_config.json          # Main configuration file
├── config.dart              # Export file
├── app_config_service.dart  # Configuration service
├── app_theme.dart           # Dynamic theme builder
├── dynamic_colors.dart      # Dynamic color accessor
├── README.md                # This documentation
└── models/
    ├── app_config_model.dart    # Root config model
    ├── theme_config.dart        # Theme configuration
    ├── branding_config.dart     # Branding configuration
    ├── feature_config.dart      # Feature flags
    ├── navigation_config.dart   # Navigation configuration
    ├── ui_config.dart           # UI configuration
    └── home_config.dart         # Home sections configuration
```

## Best Practices

1. **Always use DynamicColors** instead of hardcoded colors
2. **Check feature flags** before showing optional UI
3. **Use theme configuration** for consistent styling
4. **Leverage home sections** for flexible home page layout
5. **Keep config organized** by feature priority

## Migrating from Hardcoded Values

### Before (Hardcoded)

```dart
Container(
  color: Color(0xFFFF9500),
  child: Text(
    'Hello',
    style: TextStyle(color: Colors.white),
  ),
);
```

### After (Configurable)

```dart
Container(
  color: DynamicColors.instance.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: DynamicColors.instance.textInverse),
  ),
);
```

## Troubleshooting

### Config not loading
- Check that `app_config.json` is added to `pubspec.yaml` assets
- Verify JSON syntax is valid
- Check console for error messages

### Colors not updating
- Call `DynamicColors.refresh()` after config changes
- Ensure widgets are rebuilt after config update

### Features not toggling
- Verify feature name matches JSON key exactly
- Check parent group (`core`, `primary`, etc.) is enabled

