import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];

  final List<String> _recentSearches = [
    'Wireless headphones',
    'Smart watch',
    'Running shoes',
    'Laptop bag',
    'Coffee maker',
  ];

  final List<String> _popularSearches = [
    'iPhone',
    'Nike',
    'Samsung',
    'Apple Watch',
    'Adidas',
    'Sony',
    'AirPods',
    'MacBook',
  ];

  final List<Map<String, dynamic>> _trendingProducts = [
    {'name': 'Wireless Earbuds Pro', 'price': 79.99, 'rating': 4.7, 'color': const Color(0xFF6C5CE7)},
    {'name': 'Smart Fitness Band', 'price': 49.99, 'rating': 4.5, 'color': const Color(0xFF00B894)},
    {'name': 'Portable Charger', 'price': 29.99, 'rating': 4.8, 'color': const Color(0xFFE84393)},
    {'name': 'Bluetooth Speaker', 'price': 59.99, 'rating': 4.6, 'color': const Color(0xFFFF7675)},
  ];

  final List<Map<String, dynamic>> _allProducts = [
    {'name': 'Wireless Bluetooth Headphones', 'price': 129.99, 'color': const Color(0xFF2D3436)},
    {'name': 'Smart Watch Series 5', 'price': 299.00, 'color': const Color(0xFF6C5CE7)},
    {'name': 'Running Shoes Air Max', 'price': 89.99, 'color': const Color(0xFF00B894)},
    {'name': 'Designer Leather Bag', 'price': 149.00, 'color': const Color(0xFFE84393)},
    {'name': 'Wireless Earbuds Pro', 'price': 79.99, 'color': const Color(0xFF6C5CE7)},
    {'name': 'Smart Fitness Band', 'price': 49.99, 'color': const Color(0xFF00B894)},
    {'name': 'Portable Charger 20000mAh', 'price': 29.99, 'color': const Color(0xFFE84393)},
    {'name': 'Bluetooth Speaker Waterproof', 'price': 59.99, 'color': const Color(0xFFFF7675)},
    {'name': 'Laptop Stand Aluminum', 'price': 45.99, 'color': const Color(0xFF636E72)},
    {'name': 'USB-C Hub 7-in-1', 'price': 35.99, 'color': const Color(0xFF74B9FF)},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchResults = _allProducts
            .where((product) => product['name'].toString().toLowerCase().contains(query))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(),
      body: _isSearching ? _buildSearchResults() : _buildSearchSuggestions(),
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
      title: Container(
        height: 44,
        decoration: BoxDecoration(color: AppColor.reGreyF9F9F9, borderRadius: BorderRadius.circular(12)),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C),
            prefixIcon: Icon(Icons.search, color: AppColor.reGrey9C9C9C, size: 20),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: AppColor.reGrey666666, size: 18),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          style: AppTextStyle.regular14.copyWith(color: AppColor.reBlack393939),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              context.router.push(ProductsView(category: value));
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              context.router.push(ProductsView(category: _searchController.text));
            }
          },
          child: Text('Search', style: AppTextStyle.semiBold14.copyWith(color: AppColor.reOrangeFF9500)),
        ),
      ],
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            _buildSectionHeader(
              'Recent Searches',
              onClear: () {
                setState(() => _recentSearches.clear());
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _recentSearches.map((search) => _buildSearchChip(search, Icons.history)).toList(),
              ),
            ),
          ],
          const SizedBox(height: 24),
          // Popular Searches
          _buildSectionHeader('Popular Searches'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _popularSearches
                  .map((search) => _buildSearchChip(search, Icons.trending_up))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          // Trending Products
          _buildSectionHeader('Trending Now 🔥'),
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: _trendingProducts.length,
              itemBuilder: (context, index) => _buildTrendingCard(_trendingProducts[index]),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onClear}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack252525)),
          if (onClear != null)
            GestureDetector(
              onTap: onClear,
              child: Text('Clear', style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500)),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
        context.router.push(ProductsView(category: label));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.reGreyD7D7D7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColor.reGrey666666),
            const SizedBox(width: 6),
            Text(label, style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => context.router.push(ProductDetailsView(productId: '1')),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: (product['color'] as Color).withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    size: 40,
                    color: (product['color'] as Color).withOpacity(0.5),
                  ),
                ),
              ),
            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product['price']}',
                        style: AppTextStyle.bold14.copyWith(color: AppColor.reOrangeFF9500),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 12, color: AppColor.reYellowFF9500),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: AppColor.reGreyD7D7D7),
            const SizedBox(height: 16),
            Text('No results found', style: AppTextStyle.medium16.copyWith(color: AppColor.reGrey666666)),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) => _buildSearchResultItem(_searchResults[index], index),
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> product, int index) {
    return GestureDetector(
      onTap: () => context.router.push(ProductDetailsView(productId: index.toString())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: (product['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.shopping_bag, color: (product['color'] as Color).withOpacity(0.5), size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
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
                  Text(
                    '\$${product['price']}',
                    style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.reGrey9C9C9C),
          ],
        ),
      ),
    );
  }
}
