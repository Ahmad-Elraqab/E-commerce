import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class ProductDetailsView extends StatefulWidget {
  final String productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int _currentImageIndex = 0;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 1;
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isExpanded = false;

  final List<Color> _colors = [
    const Color(0xFF2D3436),
    const Color(0xFF6C5CE7),
    const Color(0xFFE84393),
    const Color(0xFF00B894),
    const Color(0xFFFF7675),
  ];

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  final Map<String, dynamic> _product = {
    'name': 'Premium Wireless Headphones',
    'brand': 'AudioTech Pro',
    'price': 129.99,
    'originalPrice': 199.99,
    'rating': 4.8,
    'reviews': 245,
    'description':
        'Experience premium sound quality with our latest wireless headphones. '
        'Featuring active noise cancellation, 30-hour battery life, and ultra-comfortable '
        'memory foam ear cushions. Perfect for music lovers, gamers, and professionals alike.',
    'features': [
      'Active Noise Cancellation',
      '30-Hour Battery Life',
      'Premium Memory Foam Cushions',
      'Bluetooth 5.0 Connectivity',
      'Built-in Microphone',
      'Foldable Design',
    ],
    'inStock': true,
    'stockCount': 23,
  };

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'John D.',
      'rating': 5,
      'date': '2 days ago',
      'comment': 'Amazing sound quality! Best headphones I\'ve ever owned.',
      'helpful': 24,
    },
    {
      'name': 'Sarah M.',
      'rating': 4,
      'date': '1 week ago',
      'comment': 'Great product, but the noise cancellation could be better.',
      'helpful': 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reWhiteFFFFFF,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor: AppColor.reWhiteFFFFFF,
                elevation: 0,
                pinned: true,
                expandedHeight: 360,
                leading: _buildBackButton(),
                actions: [
                  _buildActionButton(Icons.share_outlined, () {}),
                  _buildActionButton(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    () => setState(() => _isFavorite = !_isFavorite),
                    color: _isFavorite ? AppColor.reRedFF3B30 : null,
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(background: _buildImageGallery()),
              ),
              // Product Info
              SliverToBoxAdapter(child: _buildProductInfo()),
              // Spacer for bottom bar
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          // Bottom Bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: AppColor.reBlack393939, size: 18),
        onPressed: () => context.router.pop(),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap, {Color? color}) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: IconButton(
        icon: Icon(icon, color: color ?? AppColor.reBlack393939, size: 20),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildImageGallery() {
    return Stack(
      children: [
        // Main Image
        Container(
          color: _colors[_selectedColorIndex].withOpacity(0.1),
          child: PageView.builder(
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Center(
                child: Icon(
                  Icons.headphones,
                  size: 180,
                  color: _colors[_selectedColorIndex].withOpacity(0.6),
                ),
              );
            },
          ),
        ),
        // Image Indicators
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentImageIndex == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentImageIndex == index ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    final discount = ((_product['originalPrice'] - _product['price']) / _product['originalPrice'] * 100)
        .round();

    return Container(
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand & Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _product['brand'],
                        style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _product['name'],
                        style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.reGreen00AF6C.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'In Stock',
                    style: AppTextStyle.medium12.copyWith(color: AppColor.reGreen00AF6C),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Rating
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.reYellowFF9500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: AppColor.reYellowFF9500, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${_product['rating']}',
                        style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_product['reviews']} Reviews',
                  style: AppTextStyle.medium14.copyWith(color: AppColor.reGrey666666),
                ),
                const Spacer(),
                Text(
                  '${_product['stockCount']} left',
                  style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${_product['price']}',
                  style: AppTextStyle.bold32.copyWith(color: AppColor.reOrangeFF9500),
                ),
                const SizedBox(width: 12),
                Text(
                  '\$${_product['originalPrice']}',
                  style: AppTextStyle.regular20.copyWith(
                    color: AppColor.reGrey9C9C9C,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.reRedFF3B30,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('-$discount%', style: AppTextStyle.bold12.copyWith(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Color Selection
            Text('Color', style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939)),
            const SizedBox(height: 12),
            Row(
              children: List.generate(
                _colors.length,
                (index) => GestureDetector(
                  onTap: () => setState(() => _selectedColorIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 12),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _colors[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColorIndex == index ? AppColor.reOrangeFF9500 : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _colors[index].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _selectedColorIndex == index
                        ? Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Size Selection
            Text('Size', style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939)),
            const SizedBox(height: 12),
            Row(
              children: List.generate(
                _sizes.length,
                (index) => GestureDetector(
                  onTap: () => setState(() => _selectedSizeIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _selectedSizeIndex == index ? AppColor.reOrangeFF9500 : AppColor.reGreyF9F9F9,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedSizeIndex == index ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _sizes[index],
                        style: AppTextStyle.semiBold14.copyWith(
                          color: _selectedSizeIndex == index ? Colors.white : AppColor.reBlack4D4D4D,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Quantity
            Row(
              children: [
                Text('Quantity', style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939)),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.reGreyF9F9F9,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildQuantityButton(Icons.remove, () {
                        if (_quantity > 1) setState(() => _quantity--);
                      }),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          '$_quantity',
                          style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack393939),
                        ),
                      ),
                      _buildQuantityButton(Icons.add, () => setState(() => _quantity++)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Description
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939),
                      ),
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more, color: AppColor.reGrey666666),
                    ],
                  ),
                  const SizedBox(height: 8),
                  AnimatedCrossFade(
                    firstChild: Text(
                      _product['description'],
                      style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666, height: 1.6),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _product['description'],
                          style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Features',
                          style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939),
                        ),
                        const SizedBox(height: 8),
                        ...(_product['features'] as List<String>).map(
                          (feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: AppColor.reGreen00AF6C, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  feature,
                                  style: AppTextStyle.regular14.copyWith(color: AppColor.reBlack4D4D4D),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Reviews Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reviews', style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939)),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
                  ),
                ),
              ],
            ),
            ..._reviews.map((review) => _buildReviewCard(review)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: AppColor.reGreyF9F9F9, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppColor.reBlack4D4D4D, size: 20),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColor.reGreyF9F9F9, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColor.reOrangeFF9500.withOpacity(0.2),
                child: Text(
                  review['name'].toString()[0],
                  style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < review['rating'] ? Icons.star : Icons.star_border,
                            color: AppColor.reYellowFF9500,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey9C9C9C),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['comment'],
            style: AppTextStyle.regular14.copyWith(color: AppColor.reBlack4D4D4D, height: 1.5),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.thumb_up_outlined, size: 16, color: AppColor.reGrey666666),
              const SizedBox(width: 4),
              Text(
                'Helpful (${review['helpful']})',
                style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5)),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price', style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666)),
                    Text(
                      '\$${(_product['price'] * _quantity).toStringAsFixed(2)}',
                      style: AppTextStyle.bold24.copyWith(color: AppColor.reOrangeFF9500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to cart!'),
                        backgroundColor: AppColor.reGreen00AF6C,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.reOrangeFF9500,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Add to Cart', style: AppTextStyle.semiBold16.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
