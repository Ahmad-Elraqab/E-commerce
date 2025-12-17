import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';
import 'package:taxi_client_app/core/di/injection_container.dart';
import 'package:taxi_client_app/domain/entities/category.dart';
import 'package:taxi_client_app/presentation/view_models/categories_view_model.dart';

@RoutePage()
class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  late CategoriesViewModel _viewModel;

  // Fallback static categories
  final List<Map<String, dynamic>> _staticCategories = [
    {'name': 'Electronics', 'icon': Icons.devices, 'color': const Color(0xFF6C5CE7), 'itemCount': 1250},
    {'name': 'Fashion', 'icon': Icons.checkroom, 'color': const Color(0xFFE84393), 'itemCount': 3420},
    {
      'name': 'Home & Living',
      'icon': Icons.home_outlined,
      'color': const Color(0xFFFF7675),
      'itemCount': 890,
    },
    {
      'name': 'Sports & Outdoors',
      'icon': Icons.sports_basketball,
      'color': const Color(0xFF00B894),
      'itemCount': 650,
    },
    {
      'name': 'Beauty & Health',
      'icon': Icons.spa_outlined,
      'color': const Color(0xFFFDAA5D),
      'itemCount': 1100,
    },
    {'name': 'Books & Media', 'icon': Icons.menu_book, 'color': const Color(0xFF74B9FF), 'itemCount': 2300},
  ];

  final Map<String, IconData> _iconMap = {
    'electronics': Icons.devices,
    'clothing': Icons.checkroom,
    'shirts': Icons.checkroom,
    'sweatshirts': Icons.checkroom,
    'pants': Icons.checkroom,
    'merch': Icons.local_offer,
    'beauty-&-health': Icons.spa_outlined,
    'home-&-garden': Icons.home_outlined,
    'sports-&-outdoors': Icons.sports_basketball,
    'accessories': Icons.watch,
    'kitchen-&-dining': Icons.restaurant,
    'pet-supplies': Icons.pets,
    'books-&-stationery': Icons.menu_book,
    'toys-&-games': Icons.toys_outlined,
  };

  final List<Color> _defaultColors = [
    const Color(0xFF6C5CE7),
    const Color(0xFFE84393),
    const Color(0xFFFF7675),
    const Color(0xFF00B894),
    const Color(0xFFFDAA5D),
    const Color(0xFF74B9FF),
    const Color(0xFFE17055),
    const Color(0xFF636E72),
    const Color(0xFF26DE81),
    const Color(0xFFFC5C65),
    const Color(0xFFF8B500),
    const Color(0xFF4B6584),
    const Color(0xFF14B8A6),
    const Color(0xFF6366F1),
  ];

  @override
  void initState() {
    super.initState();
    _viewModel = sl<CategoriesViewModel>();
    _viewModel.fetchCategories();
  }

  Color _getCategoryColor(ProductCategory category, int index) {
    if (category.color != null) {
      try {
        final colorStr = category.color!.replaceAll('#', '');
        return Color(int.parse('FF$colorStr', radix: 16));
      } catch (_) {}
    }
    return _defaultColors[index % _defaultColors.length];
  }

  IconData _getCategoryIcon(ProductCategory category) {
    return _iconMap[category.handle] ?? Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: AppColor.reGreyF9F9F9,
        appBar: _buildAppBar(),
        body: Consumer<CategoriesViewModel>(builder: (context, viewModel, child) => _buildBody(viewModel)),
      ),
    );
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

  Widget _buildBody(CategoriesViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: () => viewModel.fetchCategories(),
      color: AppColor.reOrangeFF9500,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildFeaturedBanner(viewModel)),
          if (viewModel.state == CategoriesViewState.loading)
            const SliverToBoxAdapter(
              child: Center(
                child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()),
              ),
            )
          else if (viewModel.state == CategoriesViewState.error && viewModel.categories.isEmpty)
            SliverToBoxAdapter(child: _buildErrorWidget(viewModel))
          else
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
                  (context, index) {
                    if (viewModel.categories.isNotEmpty) {
                      return _buildApiCategoryCard(viewModel.categories[index], index);
                    } else {
                      return _buildStaticCategoryCard(_staticCategories[index]);
                    }
                  },
                  childCount: viewModel.categories.isNotEmpty
                      ? viewModel.categories.length
                      : _staticCategories.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(CategoriesViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColor.reWhiteFFFFFF, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Icon(Icons.cloud_off, size: 48, color: AppColor.reGrey9C9C9C),
          const SizedBox(height: 16),
          Text(
            'Failed to load categories',
            style: AppTextStyle.medium16.copyWith(color: AppColor.reBlack393939),
          ),
          const SizedBox(height: 8),
          Text('Using cached data', style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => viewModel.fetchCategories(),
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.reOrangeFF9500),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner(CategoriesViewModel viewModel) {
    final categoryCount = viewModel.categories.isNotEmpty
        ? viewModel.categories.length
        : _staticCategories.length;

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
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Explore $categoryCount Categories',
                            style: AppTextStyle.bold20.copyWith(color: Colors.white),
                          ),
                          if (viewModel.categories.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('LIVE', style: AppTextStyle.bold10.copyWith(color: Colors.white)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.categories.isNotEmpty
                            ? 'From TuwaTech Store API'
                            : 'Find what you\'re looking for',
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

  Widget _buildApiCategoryCard(ProductCategory category, int index) {
    final color = _getCategoryColor(category, index);
    final icon = _getCategoryIcon(category);
    final hasImage = category.imageUrl != null;

    return GestureDetector(
      onTap: () => context.router.push(ProductsView(category: category.name)),
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
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: hasImage
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: CachedNetworkImage(
                              imageUrl: category.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: color.withOpacity(0.1),
                                child: Center(child: CircularProgressIndicator(color: color, strokeWidth: 2)),
                              ),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(icon, color: color, size: 40)),
                            ),
                          )
                        : Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(icon, color: color, size: 32),
                            ),
                          ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.5), blurRadius: 4)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                          category.name,
                          style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (category.metadataDescription != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            category.metadataDescription!,
                            style: AppTextStyle.regular10.copyWith(color: AppColor.reGrey9C9C9C),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Browse', style: AppTextStyle.medium12.copyWith(color: color)),
                        Icon(Icons.arrow_forward_ios, size: 12, color: color),
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

  Widget _buildStaticCategoryCard(Map<String, dynamic> category) {
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
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
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
              ),
            ),
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
