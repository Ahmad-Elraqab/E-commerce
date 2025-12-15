import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'id': '1',
      'name': 'Wireless Bluetooth Headphones Pro',
      'price': 129.99,
      'originalPrice': 199.99,
      'rating': 4.8,
      'reviews': 245,
      'color': const Color(0xFF2D3436),
      'inStock': true,
    },
    {
      'id': '2',
      'name': 'Smart Watch Series 5',
      'price': 299.00,
      'originalPrice': 399.00,
      'rating': 4.6,
      'reviews': 189,
      'color': const Color(0xFF6C5CE7),
      'inStock': true,
    },
    {
      'id': '3',
      'name': 'Running Shoes Air Max',
      'price': 89.99,
      'originalPrice': 120.00,
      'rating': 4.7,
      'reviews': 312,
      'color': const Color(0xFF00B894),
      'inStock': false,
    },
    {
      'id': '4',
      'name': 'Designer Leather Bag',
      'price': 149.00,
      'originalPrice': 200.00,
      'rating': 4.9,
      'reviews': 156,
      'color': const Color(0xFFE84393),
      'inStock': true,
    },
    {
      'id': '5',
      'name': 'Premium Coffee Maker',
      'price': 199.99,
      'originalPrice': 249.99,
      'rating': 4.8,
      'reviews': 234,
      'color': const Color(0xFFE17055),
      'inStock': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(),
      body: _wishlistItems.isEmpty ? _buildEmptyWishlist() : _buildWishlistContent(),
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
      title: Text('My Wishlist', style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525)),
      centerTitle: true,
      actions: [
        if (_wishlistItems.isNotEmpty)
          TextButton(
            onPressed: _showClearDialog,
            child: Text('Clear All', style: AppTextStyle.medium14.copyWith(color: AppColor.reRedFF3B30)),
          ),
      ],
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(color: AppColor.reRedFF3B30.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.favorite_border, size: 60, color: AppColor.reRedFF3B30),
          ),
          const SizedBox(height: 24),
          Text('Your Wishlist is Empty', style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525)),
          const SizedBox(height: 8),
          Text(
            'Save items you love by tapping\nthe heart icon.',
            style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.router.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.reOrangeFF9500,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('Start Shopping', style: AppTextStyle.semiBold16.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistContent() {
    return Column(
      children: [
        // Item Count
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColor.reWhiteFFFFFF,
          child: Row(
            children: [
              Text(
                '${_wishlistItems.length} items',
                style: AppTextStyle.medium14.copyWith(color: AppColor.reGrey666666),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(Icons.sort, size: 18, color: AppColor.reBlack4D4D4D),
                    const SizedBox(width: 4),
                    Text('Sort', style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemCount: _wishlistItems.length,
            itemBuilder: (context, index) => _buildWishlistCard(_wishlistItems[index], index),
          ),
        ),
      ],
    );
  }

  Widget _buildWishlistCard(Map<String, dynamic> item, int index) {
    final discount = ((item['originalPrice'] - item['price']) / item['originalPrice'] * 100).round();

    return GestureDetector(
      onTap: () => context.router.push(ProductDetailsView(productId: item['id'])),
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
                      color: (item['color'] as Color).withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 50,
                        color: (item['color'] as Color).withOpacity(0.5),
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
                  // Remove Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _wishlistItems.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Removed from wishlist'),
                            backgroundColor: AppColor.reBlack393939,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: AppColor.reOrangeFF9500,
                              onPressed: () {
                                setState(() {
                                  _wishlistItems.insert(index, item);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                        ),
                        child: Icon(Icons.favorite, size: 16, color: AppColor.reRedFF3B30),
                      ),
                    ),
                  ),
                  // Out of Stock Badge
                  if (!item['inStock'])
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        color: Colors.black.withOpacity(0.7),
                        child: Text(
                          'Out of Stock',
                          style: AppTextStyle.semiBold12.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
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
                      item['name'],
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
                              '${item['rating']}',
                              style: AppTextStyle.medium12.copyWith(color: AppColor.reBlack4D4D4D),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${item['price']}',
                              style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                            ),
                            GestureDetector(
                              onTap: item['inStock']
                                  ? () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Added to cart!'),
                                          backgroundColor: AppColor.reGreen00AF6C,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: item['inStock'] ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.add_shopping_cart, size: 16, color: Colors.white),
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

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Clear Wishlist', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
        content: Text(
          'Are you sure you want to remove all items from your wishlist?',
          style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTextStyle.medium14.copyWith(color: AppColor.reGrey666666)),
          ),
          TextButton(
            onPressed: () {
              setState(() => _wishlistItems.clear());
              Navigator.pop(context);
            },
            child: Text('Clear', style: AppTextStyle.medium14.copyWith(color: AppColor.reRedFF3B30)),
          ),
        ],
      ),
    );
  }
}
