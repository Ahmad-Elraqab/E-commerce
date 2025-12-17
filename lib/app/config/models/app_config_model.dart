import 'package:taxi_client_app/app/config/models/branding_config.dart';
import 'package:taxi_client_app/app/config/models/feature_config.dart';
import 'package:taxi_client_app/app/config/models/home_config.dart';
import 'package:taxi_client_app/app/config/models/navigation_config.dart';
import 'package:taxi_client_app/app/config/models/theme_config.dart';
import 'package:taxi_client_app/app/config/models/ui_config.dart';

/// Root configuration model that holds all app settings
class AppConfig {
  final String version;
  final String? lastUpdated;
  final AppInfo app;
  final BrandingConfig branding;
  final ThemeConfig theme;
  final FeatureConfig features;
  final NavigationConfig navigation;
  final UIConfig ui;
  final HomeConfig home;
  final ApiConfig api;
  final LocalizationConfig localization;

  const AppConfig({
    required this.version,
    this.lastUpdated,
    required this.app,
    required this.branding,
    required this.theme,
    required this.features,
    required this.navigation,
    required this.ui,
    required this.home,
    required this.api,
    required this.localization,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      version: json['version'] ?? '1.0.0',
      lastUpdated: json['lastUpdated'],
      app: AppInfo.fromJson(json['app'] ?? {}),
      branding: BrandingConfig.fromJson(json['branding'] ?? {}),
      theme: ThemeConfig.fromJson(json['theme'] ?? {}),
      features: FeatureConfig.fromJson(json['features'] ?? {}),
      navigation: NavigationConfig.fromJson(json['navigation'] ?? {}),
      ui: UIConfig.fromJson(json['ui'] ?? {}),
      home: HomeConfig.fromJson(json['home'] ?? {}),
      api: ApiConfig.fromJson(json['api'] ?? {}),
      localization: LocalizationConfig.fromJson(json['localization'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'version': version,
    'lastUpdated': lastUpdated,
    'app': app.toJson(),
    'branding': branding.toJson(),
    'theme': theme.toJson(),
    'features': features.toJson(),
    'navigation': navigation.toJson(),
    'ui': ui.toJson(),
    'home': home.toJson(),
    'api': api.toJson(),
    'localization': localization.toJson(),
  };

  /// Creates a default configuration
  factory AppConfig.defaults() {
    return AppConfig(
      version: '1.0.0',
      app: AppInfo.defaults(),
      branding: BrandingConfig.defaults(),
      theme: ThemeConfig.defaults(),
      features: FeatureConfig.defaults(),
      navigation: NavigationConfig.defaults(),
      ui: UIConfig.defaults(),
      home: HomeConfig.defaults(),
      api: ApiConfig.defaults(),
      localization: LocalizationConfig.defaults(),
    );
  }
}

/// App information configuration
class AppInfo {
  final String name;
  final String tagline;
  final String bundleId;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String? websiteUrl;
  final String? supportEmail;
  final String? privacyPolicyUrl;
  final String? termsOfServiceUrl;

  const AppInfo({
    required this.name,
    required this.tagline,
    required this.bundleId,
    this.appStoreUrl,
    this.playStoreUrl,
    this.websiteUrl,
    this.supportEmail,
    this.privacyPolicyUrl,
    this.termsOfServiceUrl,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      name: json['name'] ?? 'App',
      tagline: json['tagline'] ?? '',
      bundleId: json['bundleId'] ?? 'com.app',
      appStoreUrl: json['appStoreUrl'],
      playStoreUrl: json['playStoreUrl'],
      websiteUrl: json['websiteUrl'],
      supportEmail: json['supportEmail'],
      privacyPolicyUrl: json['privacyPolicyUrl'],
      termsOfServiceUrl: json['termsOfServiceUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagline': tagline,
    'bundleId': bundleId,
    'appStoreUrl': appStoreUrl,
    'playStoreUrl': playStoreUrl,
    'websiteUrl': websiteUrl,
    'supportEmail': supportEmail,
    'privacyPolicyUrl': privacyPolicyUrl,
    'termsOfServiceUrl': termsOfServiceUrl,
  };

  factory AppInfo.defaults() {
    return const AppInfo(name: 'ShopEase', tagline: 'Shop Smart, Live Better', bundleId: 'com.shopease.app');
  }
}

/// API configuration
class ApiConfig {
  final String baseUrl;
  final String version;
  final int timeout;
  final int retryAttempts;
  final bool cacheEnabled;
  final int cacheDuration;

  const ApiConfig({
    required this.baseUrl,
    required this.version,
    required this.timeout,
    required this.retryAttempts,
    required this.cacheEnabled,
    required this.cacheDuration,
  });

  factory ApiConfig.fromJson(Map<String, dynamic> json) {
    return ApiConfig(
      baseUrl: json['baseUrl'] ?? '',
      version: json['version'] ?? 'v1',
      timeout: json['timeout'] ?? 30000,
      retryAttempts: json['retryAttempts'] ?? 3,
      cacheEnabled: json['cacheEnabled'] ?? true,
      cacheDuration: json['cacheDuration'] ?? 300,
    );
  }

  Map<String, dynamic> toJson() => {
    'baseUrl': baseUrl,
    'version': version,
    'timeout': timeout,
    'retryAttempts': retryAttempts,
    'cacheEnabled': cacheEnabled,
    'cacheDuration': cacheDuration,
  };

  factory ApiConfig.defaults() {
    return const ApiConfig(
      baseUrl: 'https://api.shopease.com',
      version: 'v1',
      timeout: 30000,
      retryAttempts: 3,
      cacheEnabled: true,
      cacheDuration: 300,
    );
  }
}

/// Localization configuration
class LocalizationConfig {
  final String defaultLocale;
  final List<String> supportedLocales;
  final String fallbackLocale;
  final List<String> rtlLanguages;

  const LocalizationConfig({
    required this.defaultLocale,
    required this.supportedLocales,
    required this.fallbackLocale,
    required this.rtlLanguages,
  });

  factory LocalizationConfig.fromJson(Map<String, dynamic> json) {
    return LocalizationConfig(
      defaultLocale: json['defaultLocale'] ?? 'en',
      supportedLocales: List<String>.from(json['supportedLocales'] ?? ['en']),
      fallbackLocale: json['fallbackLocale'] ?? 'en',
      rtlLanguages: List<String>.from(json['rtlLanguages'] ?? ['ar']),
    );
  }

  Map<String, dynamic> toJson() => {
    'defaultLocale': defaultLocale,
    'supportedLocales': supportedLocales,
    'fallbackLocale': fallbackLocale,
    'rtlLanguages': rtlLanguages,
  };

  factory LocalizationConfig.defaults() {
    return const LocalizationConfig(
      defaultLocale: 'en',
      supportedLocales: ['en', 'ar'],
      fallbackLocale: 'en',
      rtlLanguages: ['ar'],
    );
  }

  bool isRtl(String locale) => rtlLanguages.contains(locale);
}
