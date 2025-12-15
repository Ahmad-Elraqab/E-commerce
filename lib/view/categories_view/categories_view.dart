import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'color': const Color(0xFF6C5CE7),
      'itemCount': 1250,
      'subcategories': ['Phones', 'Laptops', 'Tablets', 'Accessories'],
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'color': const Color(0xFFE84393),
      'itemCount': 3420,
      'subcategories': ['Men', 'Women', 'Kids', 'Accessories'],
    },
    {
      'name': 'Home & Living',
      'icon': Icons.home_outlined,
      'color': const Color(0xFFFF7675),
      'itemCount': 890,
      'subcategories': ['Furniture', 'Decor', 'Kitchen', 'Bedding'],
    },
    {
      'name': 'Sports & Outdoors',
      'icon': Icons.sports_basketball,
      'color': const Color(0xFF00B894),
      'itemCount': 650,
      'subcategories': ['Fitness', 'Cycling', 'Camping', 'Swimming'],
    },
    {
      'name': 'Beauty & Health',
      'icon': Icons.spa_outlined,
      'color': const Color(0xFFFDAA5D),
      'itemCount': 1100,
      'subcategories': ['Skincare', 'Makeup', 'Hair Care', 'Wellness'],
    },
    {
      'name': 'Books & Media',
      'icon': Icons.menu_book,
      'color': const Color(0xFF74B9FF),
      'itemCount': 2300,
      'subcategories': ['Fiction', 'Non-Fiction', 'E-books', 'Audiobooks'],
    },
    {
      'name': 'Toys & Games',
      'icon': Icons.toys_outlined,
      'color': const Color(0xFFE17055),
      'itemCount': 780,
      'subcategories': ['Action Figures', 'Board Games', 'Puzzles', 'Outdoor'],
    },
    {
      'name': 'Automotive',
      'icon': Icons.directions_car_outlined,
      'color': const Color(0xFF636E72),
      'itemCount': 450,
      'subcategories': ['Parts', 'Accessories', 'Tools', 'Car Care'],
    },
    {
      'name': 'Groceries',
      'icon': Icons.local_grocery_store_outlined,
      'color': const Color(0xFF26DE81),
      'itemCount': 1890,
      'subcategories': ['Fresh', 'Pantry', 'Beverages', 'Snacks'],
    },
    {
      'name': 'Pet Supplies',
      'icon': Icons.pets,
      'color': const Color(0xFFFC5C65),
      'itemCount': 340,
      'subcategories': ['Dogs', 'Cats', 'Birds', 'Fish'],
    },
    {
      'name': 'Jewelry',
      'icon': Icons.diamond_outlined,
      'color': const Color(0xFFF8B500),
      'itemCount': 560,
      'subcategories': ['Rings', 'Necklaces', 'Earrings', 'Watches'],
    },
    {
      'name': 'Office Supplies',
      'icon': Icons.business_center_outlined,
      'color': const Color(0xFF4B6584),
      'itemCount': 420,
      'subcategories': ['Stationery', 'Furniture', 'Tech', 'Organization'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColor.reGreyF9F9F9, appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.reWhiteFFFFFF,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColor.reBlack393939, size: 20),
        onPressed: () => context.router.pop(),
      ),
      title: Text('All Categories', style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColor.reBlack393939),
          onPressed: () => context.router.push(const SearchView()),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        // Featured Categories Banner
        SliverToBoxAdapter(child: _buildFeaturedBanner()),
        // Categories Grid
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCategoryCard(_categories[index]),
              childCount: _categories.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget _buildFeaturedBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Explore 12 Categories', style: AppTextStyle.bold20.copyWith(color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(
                        'Find what you\'re looking for',
                        style: AppTextStyle.regular14.copyWith(color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () => context.router.push(ProductsView(category: category['name'])),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            // Icon Section
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    // Decorative circle
                    Positioned(
                      right: -15,
                      top: -15,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: (category['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: (category['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(category['icon'], color: category['color'], size: 32),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Info Section
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['name'],
                          style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${category['itemCount']} items',
                          style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey9C9C9C),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Browse', style: AppTextStyle.medium12.copyWith(color: category['color'])),
                        Icon(Icons.arrow_forward_ios, size: 12, color: category['color']),
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
  }
}
