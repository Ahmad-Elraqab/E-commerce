import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/constants.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
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

  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'Summer Sale',
      'subtitle': 'Up to 50% OFF',
      'color': const Color(0xFFFF6B6B),
      'gradient': [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
    },
    {
      'title': 'New Arrivals',
      'subtitle': 'Check out the latest',
      'color': const Color(0xFF4ECDC4),
      'gradient': [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
    },
    {
      'title': 'Flash Deals',
      'subtitle': 'Limited time offers',
      'color': const Color(0xFF667EEA),
      'gradient': [const Color(0xFF667EEA), const Color(0xFF764BA2)],
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Electronics', 'icon': Icons.devices, 'color': const Color(0xFF6C5CE7)},
    {'name': 'Fashion', 'icon': Icons.checkroom, 'color': const Color(0xFFE84393)},
    {'name': 'Home', 'icon': Icons.home_outlined, 'color': const Color(0xFFFF7675)},
    {'name': 'Sports', 'icon': Icons.sports_basketball, 'color': const Color(0xFF00B894)},
    {'name': 'Beauty', 'icon': Icons.spa_outlined, 'color': const Color(0xFFFDAA5D)},
    {'name': 'Books', 'icon': Icons.menu_book, 'color': const Color(0xFF74B9FF)},
    {'name': 'Toys', 'icon': Icons.toys_outlined, 'color': const Color(0xFFE17055)},
    {'name': 'More', 'icon': Icons.grid_view, 'color': const Color(0xFF636E72)},
  ];

  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'name': 'Wireless Headphones',
      'price': 129.99,
      'originalPrice': 199.99,
      'rating': 4.8,
      'reviews': 245,
      'color': const Color(0xFF2D3436),
    },
    {
      'name': 'Smart Watch Pro',
      'price': 299.00,
      'originalPrice': 399.00,
      'rating': 4.6,
      'reviews': 189,
      'color': const Color(0xFF6C5CE7),
    },
    {
      'name': 'Running Shoes',
      'price': 89.99,
      'originalPrice': 120.00,
      'rating': 4.7,
      'reviews': 312,
      'color': const Color(0xFF00B894),
    },
    {
      'name': 'Designer Bag',
      'price': 149.00,
      'originalPrice': 200.00,
      'rating': 4.9,
      'reviews': 156,
      'color': const Color(0xFFE84393),
    },
  ];

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverToBoxAdapter(child: _buildAppBar()),
            // Search Bar
            SliverToBoxAdapter(child: _buildSearchBar()),
            // Banner Carousel
            SliverToBoxAdapter(child: _buildBannerCarousel()),
            // Categories Section
            SliverToBoxAdapter(child: _buildCategoriesSection()),
            // Flash Deals Section
            SliverToBoxAdapter(child: _buildSectionHeader('Flash Deals', '⚡', onTap: () {})),
            SliverToBoxAdapter(child: _buildFlashDealsSection()),
            // Featured Products Section
            SliverToBoxAdapter(child: _buildSectionHeader('Featured Products', '✨', onTap: () {})),
            SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 16), sliver: _buildProductGrid()),
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
              Text('Hello, User! 👋', style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666)),
              const SizedBox(height: 4),
              Text('Find your style', style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525)),
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
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Stack(
          children: [
            Center(child: Icon(icon, color: AppColor.reBlack393939, size: 22)),
            if (badgeCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColor.reOrangeFF9500,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      badgeCount.toString(),
                      style: AppTextStyle.bold10.copyWith(color: AppColor.reWhiteFFFFFF),
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
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColor.reGrey9C9C9C, size: 22),
            const SizedBox(width: 12),
            Text(
              'Search products, brands...',
              style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.reOrangeFF9500.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.tune, color: AppColor.reOrangeFF9500, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
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
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: banner['gradient'],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (banner['color'] as Color).withOpacity(0.3),
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
                            style: AppTextStyle.bold24.copyWith(color: Colors.white, letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            banner['subtitle'],
                            style: AppTextStyle.medium16.copyWith(color: Colors.white.withOpacity(0.9)),
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
                              style: AppTextStyle.semiBold14.copyWith(color: banner['color']),
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
                color: _currentBannerIndex == index ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
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
              Text('Categories', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
              GestureDetector(
                onTap: () => context.router.push(const CategoriesView()),
                child: Text(
                  'See All',
                  style: AppTextStyle.semiBold14.copyWith(color: AppColor.reOrangeFF9500),
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
                          color: (category['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(category['icon'], color: category['color'], size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: AppTextStyle.medium12.copyWith(color: AppColor.reBlack4D4D4D),
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
              Text(title, style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
              const SizedBox(width: 4),
              Text(emoji, style: const TextStyle(fontSize: 18)),
            ],
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Text('See All', style: AppTextStyle.semiBold14.copyWith(color: AppColor.reOrangeFF9500)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 12, color: AppColor.reOrangeFF9500),
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
          final discount = ((product['originalPrice'] - product['price']) / product['originalPrice'] * 100)
              .round();

          return GestureDetector(
            onTap: () => context.router.push(ProductDetailsView(productId: index.toString())),
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColor.reWhiteFFFFFF,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                          color: (product['color'] as Color).withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.shopping_bag,
                            size: 50,
                            color: (product['color'] as Color).withOpacity(0.5),
                          ),
                        ),
                      ),
                      // Discount badge
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColor.reRedFF3B30,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '-$discount%',
                            style: AppTextStyle.bold10.copyWith(color: Colors.white),
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
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                          ),
                          child: Icon(Icons.favorite_border, size: 16, color: AppColor.reGrey666666),
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
                          style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: AppColor.reYellowFF9500),
                            const SizedBox(width: 4),
                            Text(
                              '${product['rating']}',
                              style: AppTextStyle.medium12.copyWith(color: AppColor.reBlack4D4D4D),
                            ),
                            Text(
                              ' (${product['reviews']})',
                              style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey9C9C9C),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '\$${product['originalPrice']}',
                              style: AppTextStyle.regular12.copyWith(
                                color: AppColor.reGrey9C9C9C,
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
        return GestureDetector(
          onTap: () => context.router.push(ProductDetailsView(productId: index.toString())),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.reWhiteFFFFFF,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
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
                          color: (product['color'] as Color).withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.shopping_bag,
                            size: 50,
                            color: (product['color'] as Color).withOpacity(0.5),
                          ),
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
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                          ),
                          child: Icon(Icons.favorite_border, size: 16, color: AppColor.reGrey666666),
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
                          style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 14, color: AppColor.reYellowFF9500),
                                const SizedBox(width: 2),
                                Text(
                                  '${product['rating']}',
                                  style: AppTextStyle.medium12.copyWith(color: AppColor.reBlack4D4D4D),
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
