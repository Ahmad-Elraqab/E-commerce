import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class ProductsView extends StatefulWidget {
  final String? category;

  const ProductsView({super.key, this.category});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  bool _isGridView = true;
  String _selectedSort = 'Popular';
  RangeValues _priceRange = const RangeValues(0, 500);

  final List<String> _sortOptions = [
    'Popular',
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Wireless Bluetooth Headphones Pro',
      'price': 129.99,
      'originalPrice': 199.99,
      'rating': 4.8,
      'reviews': 245,
      'color': const Color(0xFF2D3436),
      'isFavorite': false,
    },
    {
      'name': 'Smart Watch Series 5',
      'price': 299.00,
      'originalPrice': 399.00,
      'rating': 4.6,
      'reviews': 189,
      'color': const Color(0xFF6C5CE7),
      'isFavorite': true,
    },
    {
      'name': 'Running Shoes Air Max',
      'price': 89.99,
      'originalPrice': 120.00,
      'rating': 4.7,
      'reviews': 312,
      'color': const Color(0xFF00B894),
      'isFavorite': false,
    },
    {
      'name': 'Designer Leather Bag',
      'price': 149.00,
      'originalPrice': 200.00,
      'rating': 4.9,
      'reviews': 156,
      'color': const Color(0xFFE84393),
      'isFavorite': true,
    },
    {
      'name': 'Portable Bluetooth Speaker',
      'price': 79.99,
      'originalPrice': 99.99,
      'rating': 4.5,
      'reviews': 423,
      'color': const Color(0xFFFF7675),
      'isFavorite': false,
    },
    {
      'name': 'Minimalist Desk Lamp',
      'price': 45.00,
      'originalPrice': 60.00,
      'rating': 4.4,
      'reviews': 87,
      'color': const Color(0xFFFDAA5D),
      'isFavorite': false,
    },
    {
      'name': 'Organic Cotton T-Shirt',
      'price': 35.00,
      'originalPrice': 45.00,
      'rating': 4.6,
      'reviews': 567,
      'color': const Color(0xFF74B9FF),
      'isFavorite': true,
    },
    {
      'name': 'Premium Coffee Maker',
      'price': 199.99,
      'originalPrice': 249.99,
      'rating': 4.8,
      'reviews': 234,
      'color': const Color(0xFFE17055),
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildFiltersBar(),
          Expanded(child: _isGridView ? _buildGridView() : _buildListView()),
        ],
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
      title: Text(
        widget.category ?? 'Products',
        style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColor.reBlack393939),
          onPressed: () => context.router.push(const SearchView()),
        ),
        IconButton(
          icon: Icon(Icons.shopping_bag_outlined, color: AppColor.reBlack393939),
          onPressed: () => context.router.push(const CartView()),
        ),
      ],
    );
  }

  Widget _buildFiltersBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Filter Button
          Expanded(
            child: GestureDetector(
              onTap: _showFilterSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.reGreyD7D7D7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.tune, size: 18, color: AppColor.reBlack4D4D4D),
                    const SizedBox(width: 8),
                    Text('Filter', style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Sort Button
          Expanded(
            child: GestureDetector(
              onTap: _showSortSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.reGreyD7D7D7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sort, size: 18, color: AppColor.reBlack4D4D4D),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _selectedSort,
                        style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // View Toggle
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.reGreyD7D7D7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isGridView = true),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _isGridView ? AppColor.reOrangeFF9500.withOpacity(0.1) : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(9)),
                    ),
                    child: Icon(
                      Icons.grid_view,
                      size: 18,
                      color: _isGridView ? AppColor.reOrangeFF9500 : AppColor.reGrey9C9C9C,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isGridView = false),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: !_isGridView ? AppColor.reOrangeFF9500.withOpacity(0.1) : Colors.transparent,
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(9)),
                    ),
                    child: Icon(
                      Icons.view_list,
                      size: 18,
                      color: !_isGridView ? AppColor.reOrangeFF9500 : AppColor.reGrey9C9C9C,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) => _buildGridProductCard(_products[index], index),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _products.length,
      itemBuilder: (context, index) => _buildListProductCard(_products[index], index),
    );
  }

  Widget _buildGridProductCard(Map<String, dynamic> product, int index) {
    final discount = ((product['originalPrice'] - product['price']) / product['originalPrice'] * 100).round();

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
                    width: double.infinity,
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
                  // Discount Badge
                  if (discount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.reRedFF3B30,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('-$discount%', style: AppTextStyle.bold10.copyWith(color: Colors.white)),
                      ),
                    ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          product['isFavorite'] = !product['isFavorite'];
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                        ),
                        child: Icon(
                          product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: product['isFavorite'] ? AppColor.reRedFF3B30 : AppColor.reGrey666666,
                        ),
                      ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                '\$${product['originalPrice']}',
                                style: AppTextStyle.regular12.copyWith(
                                  color: AppColor.reGrey9C9C9C,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
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
  }

  Widget _buildListProductCard(Map<String, dynamic> product, int index) {
    final discount = ((product['originalPrice'] - product['price']) / product['originalPrice'] * 100).round();

    return GestureDetector(
      onTap: () => context.router.push(ProductDetailsView(productId: index.toString())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 130,
                  decoration: BoxDecoration(
                    color: (product['color'] as Color).withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: (product['color'] as Color).withOpacity(0.5),
                    ),
                  ),
                ),
                if (discount > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColor.reRedFF3B30,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-$discount%',
                        style: AppTextStyle.bold10.copyWith(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
              ],
            ),
            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: AppColor.reYellowFF9500),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']}',
                          style: AppTextStyle.medium12.copyWith(color: AppColor.reBlack4D4D4D),
                        ),
                        Text(
                          ' (${product['reviews']} reviews)',
                          style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey9C9C9C),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${product['price']}',
                              style: AppTextStyle.bold18.copyWith(color: AppColor.reOrangeFF9500),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$${product['originalPrice']}',
                              style: AppTextStyle.regular14.copyWith(
                                color: AppColor.reGrey9C9C9C,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              product['isFavorite'] = !product['isFavorite'];
                            });
                          },
                          child: Icon(
                            product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                            size: 22,
                            color: product['isFavorite'] ? AppColor.reRedFF3B30 : AppColor.reGrey666666,
                          ),
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
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: AppColor.reWhiteFFFFFF,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.reGreyD7D7D7,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Filters', style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525)),
                    TextButton(
                      onPressed: () {
                        setSheetState(() {
                          _priceRange = const RangeValues(0, 500);
                        });
                      },
                      child: Text(
                        'Reset',
                        style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price Range
                      Text(
                        'Price Range',
                        style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${_priceRange.start.round()}',
                            style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D),
                          ),
                          Text(
                            '\$${_priceRange.end.round()}',
                            style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D),
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 500,
                        activeColor: AppColor.reOrangeFF9500,
                        inactiveColor: AppColor.reGreyD7D7D7,
                        onChanged: (values) {
                          setSheetState(() {
                            _priceRange = values;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      // Categories
                      Text(
                        'Categories',
                        style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'Electronics',
                          'Fashion',
                          'Home',
                          'Sports',
                          'Beauty',
                        ].map((cat) => _buildFilterChip(cat)).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Rating
                      Text('Rating', style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          '4+',
                          '3+',
                          '2+',
                          '1+',
                        ].map((rating) => _buildFilterChip('$rating ⭐')).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              // Apply Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.reOrangeFF9500,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: AppTextStyle.semiBold16.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.reGreyF9F9F9,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.reGreyD7D7D7),
      ),
      child: Text(label, style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D)),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColor.reGreyD7D7D7, borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Sort By', style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525)),
            ),
            ..._sortOptions.map(
              (option) => ListTile(
                title: Text(
                  option,
                  style: AppTextStyle.medium16.copyWith(
                    color: _selectedSort == option ? AppColor.reOrangeFF9500 : AppColor.reBlack393939,
                  ),
                ),
                trailing: _selectedSort == option ? Icon(Icons.check, color: AppColor.reOrangeFF9500) : null,
                onTap: () {
                  setState(() => _selectedSort = option);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
