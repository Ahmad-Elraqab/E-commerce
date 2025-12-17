/// Home screen configuration model
class HomeConfig {
  final List<HomeSection> sections;

  const HomeConfig({required this.sections});

  factory HomeConfig.fromJson(Map<String, dynamic> json) {
    final sectionsList = json['sections'] as List<dynamic>? ?? [];
    return HomeConfig(sections: sectionsList.map((s) => HomeSection.fromJson(s)).toList());
  }

  Map<String, dynamic> toJson() => {'sections': sections.map((s) => s.toJson()).toList()};

  factory HomeConfig.defaults() {
    return HomeConfig(
      sections: [
        HomeSection.defaults(id: 'search', type: 'search_bar', order: 1),
        HomeSection.defaults(id: 'banners', type: 'banner_carousel', order: 2),
        HomeSection.defaults(id: 'categories', type: 'category_list', order: 3),
        HomeSection.defaults(id: 'flash_deals', type: 'product_list', order: 4),
        HomeSection.defaults(id: 'featured', type: 'product_grid', order: 5),
      ],
    );
  }

  /// Get enabled sections sorted by order
  List<HomeSection> get enabledSections {
    return sections.where((s) => s.enabled).toList()..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Get section by id
  HomeSection? getSection(String id) {
    try {
      return sections.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Check if a section is enabled
  bool isSectionEnabled(String id) {
    return getSection(id)?.enabled ?? false;
  }
}

/// Home section configuration
class HomeSection {
  final String id;
  final String type;
  final bool enabled;
  final int order;
  final Map<String, dynamic> config;

  const HomeSection({
    required this.id,
    required this.type,
    required this.enabled,
    required this.order,
    required this.config,
  });

  factory HomeSection.fromJson(Map<String, dynamic> json) {
    return HomeSection(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      enabled: json['enabled'] ?? true,
      order: json['order'] ?? 0,
      config: Map<String, dynamic>.from(json['config'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'enabled': enabled,
    'order': order,
    'config': config,
  };

  factory HomeSection.defaults({required String id, required String type, required int order}) {
    return HomeSection(id: id, type: type, enabled: true, order: order, config: {});
  }

  /// Get a config value with type safety
  T? getConfig<T>(String key) {
    return config[key] as T?;
  }

  /// Get a config value with default
  T getConfigOrDefault<T>(String key, T defaultValue) {
    return (config[key] as T?) ?? defaultValue;
  }

  /// Check if this is a specific section type
  bool isType(HomeSectionType sectionType) => type == sectionType.value;
}

/// Enum for home section types
enum HomeSectionType {
  searchBar('search_bar'),
  bannerCarousel('banner_carousel'),
  categoryList('category_list'),
  categoryGrid('category_grid'),
  productList('product_list'),
  productGrid('product_grid'),
  featuredBanner('featured_banner'),
  countdown('countdown'),
  brands('brands'),
  recentlyViewed('recently_viewed'),
  recommendations('recommendations'),
  custom('custom');

  final String value;
  const HomeSectionType(this.value);

  static HomeSectionType fromString(String value) {
    return HomeSectionType.values.firstWhere((e) => e.value == value, orElse: () => HomeSectionType.custom);
  }
}

/// Banner carousel section configuration
class BannerCarouselConfig {
  final bool autoPlay;
  final int autoPlayInterval;
  final bool showIndicators;
  final String indicatorStyle;
  final double height;
  final double aspectRatio;

  const BannerCarouselConfig({
    required this.autoPlay,
    required this.autoPlayInterval,
    required this.showIndicators,
    required this.indicatorStyle,
    required this.height,
    required this.aspectRatio,
  });

  factory BannerCarouselConfig.fromMap(Map<String, dynamic> config) {
    return BannerCarouselConfig(
      autoPlay: config['autoPlay'] ?? true,
      autoPlayInterval: config['autoPlayInterval'] ?? 5000,
      showIndicators: config['showIndicators'] ?? true,
      indicatorStyle: config['indicatorStyle'] ?? 'dots',
      height: (config['height'] ?? 180).toDouble(),
      aspectRatio: (config['aspectRatio'] ?? 2.0).toDouble(),
    );
  }

  factory BannerCarouselConfig.defaults() {
    return const BannerCarouselConfig(
      autoPlay: true,
      autoPlayInterval: 5000,
      showIndicators: true,
      indicatorStyle: 'dots',
      height: 180,
      aspectRatio: 2.0,
    );
  }

  Duration get autoPlayDuration => Duration(milliseconds: autoPlayInterval);
}

/// Category list section configuration
class CategoryListConfig {
  final String displayMode;
  final int maxItems;
  final bool showAll;
  final bool showItemCount;
  final double itemWidth;
  final double itemHeight;

  const CategoryListConfig({
    required this.displayMode,
    required this.maxItems,
    required this.showAll,
    required this.showItemCount,
    required this.itemWidth,
    required this.itemHeight,
  });

  factory CategoryListConfig.fromMap(Map<String, dynamic> config) {
    return CategoryListConfig(
      displayMode: config['displayMode'] ?? 'horizontal',
      maxItems: config['maxItems'] ?? 8,
      showAll: config['showAll'] ?? true,
      showItemCount: config['showItemCount'] ?? false,
      itemWidth: (config['itemWidth'] ?? 75).toDouble(),
      itemHeight: (config['itemHeight'] ?? 100).toDouble(),
    );
  }

  factory CategoryListConfig.defaults() {
    return const CategoryListConfig(
      displayMode: 'horizontal',
      maxItems: 8,
      showAll: true,
      showItemCount: false,
      itemWidth: 75,
      itemHeight: 100,
    );
  }

  bool get isHorizontal => displayMode == 'horizontal';
  bool get isGrid => displayMode == 'grid';
}

/// Product list section configuration
class ProductListConfig {
  final String title;
  final String? emoji;
  final String displayMode;
  final int maxItems;
  final String filterType;
  final bool showTimer;
  final bool showSeeAll;
  final int columns;

  const ProductListConfig({
    required this.title,
    this.emoji,
    required this.displayMode,
    required this.maxItems,
    required this.filterType,
    required this.showTimer,
    required this.showSeeAll,
    required this.columns,
  });

  factory ProductListConfig.fromMap(Map<String, dynamic> config) {
    return ProductListConfig(
      title: config['title'] ?? 'Products',
      emoji: config['emoji'],
      displayMode: config['displayMode'] ?? 'horizontal',
      maxItems: config['maxItems'] ?? 10,
      filterType: config['filterType'] ?? 'all',
      showTimer: config['showTimer'] ?? false,
      showSeeAll: config['showSeeAll'] ?? true,
      columns: config['columns'] ?? 2,
    );
  }

  factory ProductListConfig.defaults() {
    return const ProductListConfig(
      title: 'Products',
      displayMode: 'horizontal',
      maxItems: 10,
      filterType: 'all',
      showTimer: false,
      showSeeAll: true,
      columns: 2,
    );
  }

  bool get isHorizontal => displayMode == 'horizontal';
  bool get isGrid => displayMode == 'grid';
}

/// Search bar section configuration
class SearchBarConfig {
  final String placeholder;
  final bool showFilter;
  final bool showVoiceSearch;
  final bool showBarcodeScanner;
  final String style;

  const SearchBarConfig({
    required this.placeholder,
    required this.showFilter,
    required this.showVoiceSearch,
    required this.showBarcodeScanner,
    required this.style,
  });

  factory SearchBarConfig.fromMap(Map<String, dynamic> config) {
    return SearchBarConfig(
      placeholder: config['placeholder'] ?? 'Search products, brands...',
      showFilter: config['showFilter'] ?? true,
      showVoiceSearch: config['showVoiceSearch'] ?? false,
      showBarcodeScanner: config['showBarcodeScanner'] ?? false,
      style: config['style'] ?? 'rounded',
    );
  }

  factory SearchBarConfig.defaults() {
    return const SearchBarConfig(
      placeholder: 'Search products, brands...',
      showFilter: true,
      showVoiceSearch: false,
      showBarcodeScanner: false,
      style: 'rounded',
    );
  }
}
