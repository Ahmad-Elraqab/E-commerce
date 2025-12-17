/// Feature configuration model with priority levels
class FeatureConfig {
  final FeatureGroup core;
  final FeatureGroup primary;
  final FeatureGroup secondary;
  final FeatureGroup tertiary;
  final FeatureGroup optional;

  const FeatureConfig({
    required this.core,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.optional,
  });

  factory FeatureConfig.fromJson(Map<String, dynamic> json) {
    return FeatureConfig(
      core: FeatureGroup.fromJson(json['core'] ?? {}, priority: 1),
      primary: FeatureGroup.fromJson(json['primary'] ?? {}, priority: 2),
      secondary: FeatureGroup.fromJson(json['secondary'] ?? {}, priority: 3),
      tertiary: FeatureGroup.fromJson(json['tertiary'] ?? {}, priority: 4),
      optional: FeatureGroup.fromJson(json['optional'] ?? {}, priority: 5),
    );
  }

  Map<String, dynamic> toJson() => {
    'core': core.toJson(),
    'primary': primary.toJson(),
    'secondary': secondary.toJson(),
    'tertiary': tertiary.toJson(),
    'optional': optional.toJson(),
  };

  factory FeatureConfig.defaults() {
    return FeatureConfig(
      core: FeatureGroup.defaults(priority: 1),
      primary: FeatureGroup.defaults(priority: 2),
      secondary: FeatureGroup.defaults(priority: 3),
      tertiary: FeatureGroup.defaults(priority: 4),
      optional: FeatureGroup.defaults(priority: 5),
    );
  }

  /// Get all enabled feature flags as a flat map
  Map<String, bool> getAllFlags() {
    final flags = <String, bool>{};
    _addGroupFlags(flags, core);
    _addGroupFlags(flags, primary);
    _addGroupFlags(flags, secondary);
    _addGroupFlags(flags, tertiary);
    _addGroupFlags(flags, optional);
    return flags;
  }

  void _addGroupFlags(Map<String, bool> flags, FeatureGroup group) {
    if (!group.enabled) return;
    for (final entry in group.items.entries) {
      flags[entry.key] = entry.value.enabled;
    }
  }

  /// Check if a specific feature is enabled
  bool isEnabled(String featureName) {
    return getAllFlags()[featureName] ?? false;
  }

  /// Get feature details by name
  FeatureItem? getFeature(String featureName) {
    for (final group in [core, primary, secondary, tertiary, optional]) {
      if (group.items.containsKey(featureName)) {
        return group.items[featureName];
      }
    }
    return null;
  }
}

/// A group of features with a priority level
class FeatureGroup {
  final bool enabled;
  final int priority;
  final Map<String, FeatureItem> items;

  const FeatureGroup({required this.enabled, required this.priority, required this.items});

  factory FeatureGroup.fromJson(Map<String, dynamic> json, {required int priority}) {
    final itemsJson = json['items'] as Map<String, dynamic>? ?? {};
    final items = <String, FeatureItem>{};

    itemsJson.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        items[key] = FeatureItem.fromJson(value, name: key);
      }
    });

    return FeatureGroup(
      enabled: json['enabled'] ?? true,
      priority: json['priority'] ?? priority,
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'priority': priority,
    'items': items.map((key, value) => MapEntry(key, value.toJson())),
  };

  factory FeatureGroup.defaults({required int priority}) {
    return FeatureGroup(enabled: true, priority: priority, items: {});
  }
}

/// Individual feature item with configuration options
class FeatureItem {
  final String name;
  final bool enabled;
  final Map<String, dynamic> options;

  const FeatureItem({required this.name, required this.enabled, this.options = const {}});

  factory FeatureItem.fromJson(Map<String, dynamic> json, {required String name}) {
    // Create a copy of json without the 'enabled' key for options
    final options = Map<String, dynamic>.from(json)..remove('enabled');

    return FeatureItem(name: name, enabled: json['enabled'] ?? true, options: options);
  }

  Map<String, dynamic> toJson() => {'enabled': enabled, ...options};

  /// Get a specific option value
  T? getOption<T>(String key) {
    return options[key] as T?;
  }

  /// Get a specific option value with a default
  T getOptionOrDefault<T>(String key, T defaultValue) {
    return (options[key] as T?) ?? defaultValue;
  }

  /// Check if an option is enabled (for boolean options)
  bool isOptionEnabled(String key) {
    return options[key] == true;
  }
}

// ============================================================================
// SPECIFIC FEATURE CONFIGURATIONS
// ============================================================================

/// Authentication feature configuration
class AuthFeatureConfig {
  final bool enabled;
  final bool allowGuestBrowsing;
  final SocialLoginConfig socialLogin;
  final bool biometricLogin;
  final bool phoneAuth;

  const AuthFeatureConfig({
    required this.enabled,
    required this.allowGuestBrowsing,
    required this.socialLogin,
    required this.biometricLogin,
    required this.phoneAuth,
  });

  factory AuthFeatureConfig.fromFeatureItem(FeatureItem? item) {
    if (item == null) return AuthFeatureConfig.defaults();

    return AuthFeatureConfig(
      enabled: item.enabled,
      allowGuestBrowsing: item.getOptionOrDefault('allowGuestBrowsing', true),
      socialLogin: SocialLoginConfig.fromMap(item.options['socialLogin'] as Map<String, dynamic>? ?? {}),
      biometricLogin: (item.options['biometricLogin'] as Map?)?['enabled'] ?? true,
      phoneAuth: (item.options['phoneAuth'] as Map?)?['enabled'] ?? false,
    );
  }

  factory AuthFeatureConfig.defaults() {
    return AuthFeatureConfig(
      enabled: true,
      allowGuestBrowsing: true,
      socialLogin: SocialLoginConfig.defaults(),
      biometricLogin: true,
      phoneAuth: false,
    );
  }
}

/// Social login configuration
class SocialLoginConfig {
  final bool enabled;
  final List<String> providers;

  const SocialLoginConfig({required this.enabled, required this.providers});

  factory SocialLoginConfig.fromMap(Map<String, dynamic> map) {
    return SocialLoginConfig(
      enabled: map['enabled'] ?? true,
      providers: List<String>.from(map['providers'] ?? ['google', 'apple']),
    );
  }

  factory SocialLoginConfig.defaults() {
    return const SocialLoginConfig(enabled: true, providers: ['google', 'apple']);
  }

  bool get hasGoogle => providers.contains('google');
  bool get hasApple => providers.contains('apple');
  bool get hasFacebook => providers.contains('facebook');
}

/// Splash screen feature configuration
class SplashFeatureConfig {
  final bool enabled;
  final int duration;
  final bool showLogo;
  final bool showLoading;
  final bool showTagline;

  const SplashFeatureConfig({
    required this.enabled,
    required this.duration,
    required this.showLogo,
    required this.showLoading,
    required this.showTagline,
  });

  factory SplashFeatureConfig.fromFeatureItem(FeatureItem? item) {
    if (item == null) return SplashFeatureConfig.defaults();

    return SplashFeatureConfig(
      enabled: item.enabled,
      duration: item.getOptionOrDefault('duration', 3000),
      showLogo: item.getOptionOrDefault('showLogo', true),
      showLoading: item.getOptionOrDefault('showLoading', true),
      showTagline: item.getOptionOrDefault('showTagline', true),
    );
  }

  factory SplashFeatureConfig.defaults() {
    return const SplashFeatureConfig(
      enabled: true,
      duration: 3000,
      showLogo: true,
      showLoading: true,
      showTagline: true,
    );
  }

  Duration get durationValue => Duration(milliseconds: duration);
}

/// Home screen feature configuration
class HomeFeatureConfig {
  final bool enabled;
  final bool showSearchBar;
  final bool showBannerCarousel;
  final bool showCategories;
  final bool showFlashDeals;
  final bool showFeaturedProducts;
  final bool showRecommendations;
  final int maxBanners;
  final String categoriesDisplayMode;

  const HomeFeatureConfig({
    required this.enabled,
    required this.showSearchBar,
    required this.showBannerCarousel,
    required this.showCategories,
    required this.showFlashDeals,
    required this.showFeaturedProducts,
    required this.showRecommendations,
    required this.maxBanners,
    required this.categoriesDisplayMode,
  });

  factory HomeFeatureConfig.fromFeatureItem(FeatureItem? item) {
    if (item == null) return HomeFeatureConfig.defaults();

    return HomeFeatureConfig(
      enabled: item.enabled,
      showSearchBar: item.getOptionOrDefault('showSearchBar', true),
      showBannerCarousel: item.getOptionOrDefault('showBannerCarousel', true),
      showCategories: item.getOptionOrDefault('showCategories', true),
      showFlashDeals: item.getOptionOrDefault('showFlashDeals', true),
      showFeaturedProducts: item.getOptionOrDefault('showFeaturedProducts', true),
      showRecommendations: item.getOptionOrDefault('showRecommendations', true),
      maxBanners: item.getOptionOrDefault('maxBanners', 5),
      categoriesDisplayMode: item.getOptionOrDefault('categoriesDisplayMode', 'horizontal'),
    );
  }

  factory HomeFeatureConfig.defaults() {
    return const HomeFeatureConfig(
      enabled: true,
      showSearchBar: true,
      showBannerCarousel: true,
      showCategories: true,
      showFlashDeals: true,
      showFeaturedProducts: true,
      showRecommendations: true,
      maxBanners: 5,
      categoriesDisplayMode: 'horizontal',
    );
  }
}

/// Cart feature configuration
class CartFeatureConfig {
  final bool enabled;
  final bool showCoupons;
  final bool showSavedForLater;
  final int maxQuantityPerItem;

  const CartFeatureConfig({
    required this.enabled,
    required this.showCoupons,
    required this.showSavedForLater,
    required this.maxQuantityPerItem,
  });

  factory CartFeatureConfig.fromFeatureItem(FeatureItem? item) {
    if (item == null) return CartFeatureConfig.defaults();

    return CartFeatureConfig(
      enabled: item.enabled,
      showCoupons: item.getOptionOrDefault('showCoupons', true),
      showSavedForLater: item.getOptionOrDefault('showSavedForLater', false),
      maxQuantityPerItem: item.getOptionOrDefault('maxQuantityPerItem', 10),
    );
  }

  factory CartFeatureConfig.defaults() {
    return const CartFeatureConfig(
      enabled: true,
      showCoupons: true,
      showSavedForLater: false,
      maxQuantityPerItem: 10,
    );
  }
}

/// Wishlist feature configuration
class WishlistFeatureConfig {
  final bool enabled;
  final bool showShareWishlist;
  final bool showMoveToCart;

  const WishlistFeatureConfig({
    required this.enabled,
    required this.showShareWishlist,
    required this.showMoveToCart,
  });

  factory WishlistFeatureConfig.fromFeatureItem(FeatureItem? item) {
    if (item == null) return WishlistFeatureConfig.defaults();

    return WishlistFeatureConfig(
      enabled: item.enabled,
      showShareWishlist: item.getOptionOrDefault('showShareWishlist', false),
      showMoveToCart: item.getOptionOrDefault('showMoveToCart', true),
    );
  }

  factory WishlistFeatureConfig.defaults() {
    return const WishlistFeatureConfig(enabled: true, showShareWishlist: false, showMoveToCart: true);
  }
}

/// Profile feature configuration
class ProfileFeatureConfig {
  final bool enabled;
  final bool showAvatar;
  final bool showEditProfile;
  final bool showAddresses;
  final bool showPaymentMethods;
  final bool showOrderHistory;
  final bool showNotificationSettings;
  final bool showLanguageSettings;
  final bool showThemeSettings;

  const ProfileFeatureConfig({
    required this.enabled,
    required this.showAvatar,
    required this.showEditProfile,
    required this.showAddresses,
    required this.showPaymentMethods,
    required this.showOrderHistory,
    required this.showNotificationSettings,
    required this.showLanguageSettings,
    required this.showThemeSettings,
  });

  factory ProfileFeatureConfig.fromFeatureItem(FeatureItem? item) {
    if (item == null) return ProfileFeatureConfig.defaults();

    return ProfileFeatureConfig(
      enabled: item.enabled,
      showAvatar: item.getOptionOrDefault('showAvatar', true),
      showEditProfile: item.getOptionOrDefault('showEditProfile', true),
      showAddresses: item.getOptionOrDefault('showAddresses', true),
      showPaymentMethods: item.getOptionOrDefault('showPaymentMethods', true),
      showOrderHistory: item.getOptionOrDefault('showOrderHistory', true),
      showNotificationSettings: item.getOptionOrDefault('showNotificationSettings', true),
      showLanguageSettings: item.getOptionOrDefault('showLanguageSettings', true),
      showThemeSettings: item.getOptionOrDefault('showThemeSettings', true),
    );
  }

  factory ProfileFeatureConfig.defaults() {
    return const ProfileFeatureConfig(
      enabled: true,
      showAvatar: true,
      showEditProfile: true,
      showAddresses: true,
      showPaymentMethods: true,
      showOrderHistory: true,
      showNotificationSettings: true,
      showLanguageSettings: true,
      showThemeSettings: true,
    );
  }
}
