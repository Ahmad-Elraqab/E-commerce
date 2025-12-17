import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/config/dynamic_colors.dart';
import 'package:taxi_client_app/app/config/models/feature_config.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();

  // Configuration
  late DynamicColors _colors;
  late HomeFeatureConfig _homeConfig;
  late String _fontFamily;

  final List<Map<String, dynamic>> _banners = [
    {'title': 'Summer Sale', 'subtitle': 'Up to 50% OFF', 'gradientIndex': 0},
    {'title': 'New Arrivals', 'subtitle': 'Check out the latest', 'gradientIndex': 1},
    {'title': 'Flash Deals', 'subtitle': 'Limited time offers', 'gradientIndex': 2},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Electronics', 'icon': Icons.devices, 'colorIndex': 0},
    {'name': 'Fashion', 'icon': Icons.checkroom, 'colorIndex': 1},
    {'name': 'Home', 'icon': Icons.home_outlined, 'colorIndex': 2},
    {'name': 'Sports', 'icon': Icons.sports_basketball, 'colorIndex': 3},
    {'name': 'Beauty', 'icon': Icons.spa_outlined, 'colorIndex': 4},
    {'name': 'Books', 'icon': Icons.menu_book, 'colorIndex': 5},
    {'name': 'Toys', 'icon': Icons.toys_outlined, 'colorIndex': 6},
    {'name': 'More', 'icon': Icons.grid_view, 'colorIndex': 7},
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'name': 'Wireless Headphones',
      'price': 129.99,
      'originalPrice': 199.99,
      'rating': 4.8,
      'reviews': 245,
      'colorIndex': 0,
    },
    {
      'name': 'Smart Watch Pro',
      'price': 299.00,
      'originalPrice': 399.00,
      'rating': 4.6,
      'reviews': 189,
      'colorIndex': 1,
    },
    {
      'name': 'Running Shoes',
      'price': 89.99,
      'originalPrice': 120.00,
      'rating': 4.7,
      'reviews': 312,
      'colorIndex': 2,
    },
    {
      'name': 'Designer Bag',
      'price': 149.00,
      'originalPrice': 200.00,
      'rating': 4.9,
      'reviews': 156,
      'colorIndex': 3,
    },
  ];

  // Category colors based on index
  final List<Color> _categoryColors = [
    const Color(0xFF6C5CE7),
    const Color(0xFFE84393),
    const Color(0xFFFF7675),
    const Color(0xFF00B894),
    const Color(0xFFFDAA5D),
    const Color(0xFF74B9FF),
    const Color(0xFFE17055),
    const Color(0xFF636E72),
  ];

  // Product colors based on index
  final List<Color> _productColors = [
    const Color(0xFF2D3436),
    const Color(0xFF6C5CE7),
    const Color(0xFF00B894),
    const Color(0xFFE84393),
  ];

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  void _loadConfig() {
    _colors = DynamicColors.instance;
    _homeConfig = AppConfigService.instance.getHomeConfig();
    _fontFamily = AppConfigService.instance.fontFamily;
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradients = AppConfigService.instance.config.theme.gradients;
    final bannerGradients = gradients.getBannerGradients();

    return Scaffold(
      backgroundColor: _colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverToBoxAdapter(child: _buildAppBar()),

            // Search Bar (configurable)
            if (_homeConfig.showSearchBar) SliverToBoxAdapter(child: _buildSearchBar()),

            // Banner Carousel (configurable)
            if (_homeConfig.showBannerCarousel)
              SliverToBoxAdapter(child: _buildBannerCarousel(bannerGradients)),

            // Categories Section (configurable)
            if (_homeConfig.showCategories) SliverToBoxAdapter(child: _buildCategoriesSection()),

            // Flash Deals Section (configurable)
            if (_homeConfig.showFlashDeals) ...[
              SliverToBoxAdapter(child: _buildSectionHeader('Flash Deals', '⚡', onTap: () {})),
              SliverToBoxAdapter(child: _buildFlashDealsSection()),
            ],

            // Featured Products Section (configurable)
            if (_homeConfig.showFeaturedProducts) ...[
              SliverToBoxAdapter(child: _buildSectionHeader('Featured Products', '✨', onTap: () {})),
              SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 16), sliver: _buildProductGrid()),
            ],

            // Bottom padding for navigation
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, User! 👋',
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _colors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Find your style',
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _colors.textPrimary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildIconButton(
                icon: Icons.favorite_border,
                onTap: () => context.router.push(const WishlistView()),
                badgeCount: 3,
              ),
              const SizedBox(width: 8),
              _buildIconButton(
                icon: Icons.shopping_bag_outlined,
                onTap: () => context.router.push(const CartView()),
                badgeCount: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap, int badgeCount = 0}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _colors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: _colors.shadow.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Stack(
          children: [
            Center(child: Icon(icon, color: _colors.textPrimary, size: 22)),
            if (badgeCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(color: _colors.primary, borderRadius: BorderRadius.circular(9)),
                  child: Center(
                    child: Text(
                      badgeCount.toString(),
                      style: TextStyle(
                        fontFamily: _fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => context.router.push(const SearchView()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: _colors.shadow.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: _colors.textDisabled, size: 22),
            const SizedBox(width: 12),
            Text(
              'Search products, brands...',
              style: TextStyle(
                fontFamily: _fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _colors.textDisabled,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.tune, color: _colors.primary, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel(List<LinearGradient> bannerGradients) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() => _currentBannerIndex = index);
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              final gradientIndex = banner['gradientIndex'] as int;
              final gradient = bannerGradients[gradientIndex % bannerGradients.length];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: gradient.colors.first.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30,
                      bottom: -40,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banner['title'],
                            style: TextStyle(
                              fontFamily: _fontFamily,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner['subtitle'],
                            style: TextStyle(
                              fontFamily: _fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              'Shop Now',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: gradient.colors.first,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentBannerIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentBannerIndex == index ? _colors.primary : _colors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _colors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => context.router.push(const CategoriesView()),
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final colorIndex = category['colorIndex'] as int;
              final categoryColor = _categoryColors[colorIndex % _categoryColors.length];

              return GestureDetector(
                onTap: () => context.router.push(ProductsView(category: category['name'])),
                child: Container(
                  width: 75,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(category['icon'], color: categoryColor, size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: TextStyle(
                          fontFamily: _fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String emoji, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _colors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              Text(emoji, style: const TextStyle(fontSize: 18)),
            ],
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontFamily: _fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _colors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 12, color: _colors.primary),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlashDealsSection() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: _featuredProducts.length,
        itemBuilder: (context, index) {
          final product = _featuredProducts[index];
          final colorIndex = product['colorIndex'] as int;
          final productColor = _productColors[colorIndex % _productColors.length];
          final discount = ((product['originalPrice'] - product['price']) / product['originalPrice'] * 100)
              .round();

          return GestureDetector(
            onTap: () => context.router.push(ProductDetailsView(productId: index.toString())),
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _colors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _colors.shadow.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image Placeholder
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: productColor.withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Center(
                          child: Icon(Icons.shopping_bag, size: 50, color: productColor.withOpacity(0.5)),
                        ),
                      ),
                      // Discount badge
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _colors.error,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '-$discount%',
                            style: TextStyle(
                              fontFamily: _fontFamily,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Wishlist button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: _colors.shadow.withOpacity(0.1), blurRadius: 5)],
                          ),
                          child: Icon(Icons.favorite_border, size: 16, color: _colors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontFamily: _fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _colors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: _colors.warning),
                            const SizedBox(width: 4),
                            Text(
                              '${product['rating']}',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: _colors.textPrimary,
                              ),
                            ),
                            Text(
                              ' (${product['reviews']})',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: _colors.textDisabled,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _colors.primary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '\$${product['originalPrice']}',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: _colors.textDisabled,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final product = _featuredProducts[index % _featuredProducts.length];
        final colorIndex = product['colorIndex'] as int;
        final productColor = _productColors[colorIndex % _productColors.length];

        return GestureDetector(
          onTap: () => context.router.push(ProductDetailsView(productId: index.toString())),
          child: Container(
            decoration: BoxDecoration(
              color: _colors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _colors.shadow.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: productColor.withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Center(
                          child: Icon(Icons.shopping_bag, size: 50, color: productColor.withOpacity(0.5)),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: _colors.shadow.withOpacity(0.1), blurRadius: 5)],
                          ),
                          child: Icon(Icons.favorite_border, size: 16, color: _colors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
                // Product Info
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontFamily: _fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _colors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _colors.primary,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: _colors.warning),
                                const SizedBox(width: 2),
                                Text(
                                  '${product['rating']}',
                                  style: TextStyle(
                                    fontFamily: _fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: 4),
    );
  }
}
