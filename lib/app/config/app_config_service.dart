import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:taxi_client_app/app/config/models/app_config_model.dart';
import 'package:taxi_client_app/app/config/models/feature_config.dart';

/// Service for loading and providing app configuration
///
/// This service handles:
/// - Loading configuration from JSON assets
/// - Providing access to configuration throughout the app
/// - Feature flag checking
/// - Theme configuration access
class AppConfigService extends ChangeNotifier {
  static AppConfigService? _instance;
  static AppConfigService get instance => _instance ??= AppConfigService._();

  AppConfigService._();

  AppConfig _config = AppConfig.defaults();
  bool _isLoaded = false;
  String? _loadError;

  /// Current app configuration
  AppConfig get config => _config;

  /// Whether the configuration has been loaded
  bool get isLoaded => _isLoaded;

  /// Error message if loading failed
  String? get loadError => _loadError;

  /// Initialize and load the configuration from the JSON asset
  Future<void> initialize({String configPath = 'lib/app/config/app_config.json'}) async {
    try {
      _loadError = null;
      final jsonString = await rootBundle.loadString(configPath);
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      _config = AppConfig.fromJson(jsonMap);
      _isLoaded = true;
      notifyListeners();

      if (kDebugMode) {
        print('✅ App configuration loaded successfully');
        print('   App: ${_config.app.name}');
        print('   Version: ${_config.version}');
      }
    } catch (e) {
      _loadError = e.toString();
      _config = AppConfig.defaults();
      _isLoaded = true; // Mark as loaded even with defaults
      notifyListeners();

      if (kDebugMode) {
        print('⚠️ Failed to load app configuration: $e');
        print('   Using default configuration');
      }
    }
  }

  /// Load configuration from a JSON string (useful for testing or remote config)
  void loadFromJson(String jsonString) {
    try {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      _config = AppConfig.fromJson(jsonMap);
      _isLoaded = true;
      _loadError = null;
      notifyListeners();
    } catch (e) {
      _loadError = e.toString();
      if (kDebugMode) {
        print('⚠️ Failed to parse configuration JSON: $e');
      }
    }
  }

  /// Load configuration from a map (useful for remote config)
  void loadFromMap(Map<String, dynamic> configMap) {
    try {
      _config = AppConfig.fromJson(configMap);
      _isLoaded = true;
      _loadError = null;
      notifyListeners();
    } catch (e) {
      _loadError = e.toString();
      if (kDebugMode) {
        print('⚠️ Failed to load configuration from map: $e');
      }
    }
  }

  /// Reset to default configuration
  void resetToDefaults() {
    _config = AppConfig.defaults();
    _isLoaded = true;
    _loadError = null;
    notifyListeners();
  }

  // ===========================================================================
  // CONVENIENCE ACCESSORS
  // ===========================================================================

  /// App information
  AppInfo get appInfo => _config.app;

  /// Theme configuration
  get theme => _config.theme;

  /// Feature configuration
  FeatureConfig get features => _config.features;

  /// Navigation configuration
  get navigation => _config.navigation;

  /// UI configuration
  get ui => _config.ui;

  /// Home configuration
  get home => _config.home;

  /// Branding configuration
  get branding => _config.branding;

  // ===========================================================================
  // FEATURE FLAG HELPERS
  // ===========================================================================

  /// Check if a feature is enabled by name
  bool isFeatureEnabled(String featureName) {
    return _config.features.isEnabled(featureName);
  }

  /// Get feature configuration by name
  FeatureItem? getFeature(String featureName) {
    return _config.features.getFeature(featureName);
  }

  /// Get all feature flags as a flat map
  Map<String, bool> getAllFeatureFlags() {
    return _config.features.getAllFlags();
  }

  /// Get authentication feature config
  AuthFeatureConfig getAuthConfig() {
    return AuthFeatureConfig.fromFeatureItem(_config.features.getFeature('authentication'));
  }

  /// Get splash feature config
  SplashFeatureConfig getSplashConfig() {
    return SplashFeatureConfig.fromFeatureItem(_config.features.getFeature('splash'));
  }

  /// Get home feature config
  HomeFeatureConfig getHomeConfig() {
    return HomeFeatureConfig.fromFeatureItem(_config.features.getFeature('home'));
  }

  /// Get cart feature config
  CartFeatureConfig getCartConfig() {
    return CartFeatureConfig.fromFeatureItem(_config.features.getFeature('cart'));
  }

  /// Get wishlist feature config
  WishlistFeatureConfig getWishlistConfig() {
    return WishlistFeatureConfig.fromFeatureItem(_config.features.getFeature('wishlist'));
  }

  /// Get profile feature config
  ProfileFeatureConfig getProfileConfig() {
    return ProfileFeatureConfig.fromFeatureItem(_config.features.getFeature('profile'));
  }

  // ===========================================================================
  // THEME HELPERS
  // ===========================================================================

  /// Get primary color
  get primaryColor => _config.theme.colors.primary.main;

  /// Get secondary color
  get secondaryColor => _config.theme.colors.secondary.main;

  /// Get accent color
  get accentColor => _config.theme.colors.accent.main;

  /// Get background color
  get backgroundColor => _config.theme.colors.background.defaultColor;

  /// Get surface color
  get surfaceColor => _config.theme.colors.surface.defaultColor;

  /// Check if dark mode
  bool get isDarkMode => _config.theme.isDark;

  /// Get font family
  String get fontFamily => _config.theme.typography.fontFamily;
}

/// Extension for easy access to config service
extension AppConfigContextExtension on AppConfigService {
  /// Shorthand for checking feature enabled
  bool feature(String name) => isFeatureEnabled(name);
}
