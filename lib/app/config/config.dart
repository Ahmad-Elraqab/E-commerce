/// App Configuration Module
///
/// This module provides JSON-based configuration for app theming, features,
/// navigation, and UI customization.
///
/// Usage:
/// ```dart
/// import 'package:taxi_client_app/app/config/config.dart';
///
/// // Access config through service
/// final config = AppConfigService.instance.config;
/// final primaryColor = config.theme.colors.primary.main;
///
/// // Check feature flags
/// if (config.features.isEnabled('wishlist')) {
///   // Show wishlist feature
/// }
/// ```

library config;

// Models
export 'models/app_config_model.dart';
export 'models/theme_config.dart';
export 'models/branding_config.dart';
export 'models/feature_config.dart';
export 'models/navigation_config.dart';
export 'models/ui_config.dart';
export 'models/home_config.dart';

// Services
export 'app_config_service.dart';

// Theme
export 'app_theme.dart';
export 'dynamic_colors.dart';
