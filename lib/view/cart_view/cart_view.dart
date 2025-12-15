import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Wireless Bluetooth Headphones',
      'price': 129.99,
      'quantity': 1,
      'color': 'Black',
      'size': 'M',
      'productColor': const Color(0xFF2D3436),
      'selected': true,
    },
    {
      'id': '2',
      'name': 'Smart Watch Series 5',
      'price': 299.00,
      'quantity': 1,
      'color': 'Silver',
      'size': '42mm',
      'productColor': const Color(0xFF6C5CE7),
      'selected': true,
    },
    {
      'id': '3',
      'name': 'Running Shoes Air Max',
      'price': 89.99,
      'quantity': 2,
      'color': 'Green',
      'size': '10',
      'productColor': const Color(0xFF00B894),
      'selected': true,
    },
  ];

  String _promoCode = '';
  double _discount = 0;
  bool _selectAll = true;

  double get _subtotal {
    return _cartItems
        .where((item) => item['selected'])
        .fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _shipping => _subtotal > 100 ? 0 : 9.99;
  double get _total => _subtotal - _discount + _shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
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
      title: Text('My Cart', style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525)),
      centerTitle: true,
      actions: [
        if (_cartItems.isNotEmpty)
          TextButton(
            onPressed: _showClearCartDialog,
            child: Text('Clear', style: AppTextStyle.medium14.copyWith(color: AppColor.reRedFF3B30)),
          ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColor.reOrangeFF9500.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shopping_cart_outlined, size: 60, color: AppColor.reOrangeFF9500),
          ),
          const SizedBox(height: 24),
          Text('Your Cart is Empty', style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525)),
          const SizedBox(height: 8),
          Text(
            'Looks like you haven\'t added\nanything to your cart yet.',
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

  Widget _buildCartContent() {
    return Column(
      children: [
        // Select All Row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColor.reWhiteFFFFFF,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectAll = !_selectAll;
                    for (var item in _cartItems) {
                      item['selected'] = _selectAll;
                    }
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _selectAll ? AppColor.reOrangeFF9500 : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _selectAll ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                      width: 2,
                    ),
                  ),
                  child: _selectAll ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Select All (${_cartItems.length} items)',
                style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
              ),
            ],
          ),
        ),
        // Cart Items List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) => _buildCartItem(_cartItems[index], index),
          ),
        ),
        // Promo Code & Summary
        _buildSummarySection(),
      ],
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['id']),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(color: AppColor.reRedFF3B30, borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (direction) {
        setState(() {
          _cartItems.removeAt(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Checkbox
              GestureDetector(
                onTap: () {
                  setState(() {
                    item['selected'] = !item['selected'];
                    _selectAll = _cartItems.every((i) => i['selected']);
                  });
                },
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: item['selected'] ? AppColor.reOrangeFF9500 : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: item['selected'] ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                      width: 2,
                    ),
                  ),
                  child: item['selected'] ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                ),
              ),
              const SizedBox(width: 12),
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: (item['productColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    size: 32,
                    color: (item['productColor'] as Color).withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['color']} • ${item['size']}',
                      style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item['price']}',
                          style: AppTextStyle.bold16.copyWith(color: AppColor.reOrangeFF9500),
                        ),
                        _buildQuantityControl(item),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityControl(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(color: AppColor.reGreyF9F9F9, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (item['quantity'] > 1) {
                setState(() => item['quantity']--);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppColor.reGreyF9F9F9, borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.remove,
                size: 16,
                color: item['quantity'] > 1 ? AppColor.reBlack4D4D4D : AppColor.reGreyD7D7D7,
              ),
            ),
          ),
          Container(
            width: 32,
            alignment: Alignment.center,
            child: Text(
              '${item['quantity']}',
              style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() => item['quantity']++);
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppColor.reGreyF9F9F9, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.add, size: 16, color: AppColor.reBlack4D4D4D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Promo Code
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.reGreyF9F9F9,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer_outlined, color: AppColor.reGrey666666, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => _promoCode = value,
                      decoration: InputDecoration(
                        hintText: 'Enter promo code',
                        hintStyle: AppTextStyle.regular14.copyWith(color: AppColor.reGrey9C9C9C),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _applyPromoCode,
                    child: Text(
                      'Apply',
                      style: AppTextStyle.semiBold14.copyWith(color: AppColor.reOrangeFF9500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Order Summary
            _buildSummaryRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Shipping',
              _shipping == 0 ? 'Free' : '\$${_shipping.toStringAsFixed(2)}',
              isGreen: _shipping == 0,
            ),
            if (_discount > 0) ...[
              const SizedBox(height: 8),
              _buildSummaryRow('Discount', '-\$${_discount.toStringAsFixed(2)}', isGreen: true),
            ],
            const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
                Text(
                  '\$${_total.toStringAsFixed(2)}',
                  style: AppTextStyle.bold24.copyWith(color: AppColor.reOrangeFF9500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Checkout Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _cartItems.any((item) => item['selected'])
                    ? () => context.router.push(const CheckoutView())
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.reOrangeFF9500,
                  disabledBackgroundColor: AppColor.reGreyD7D7D7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Proceed to Checkout', style: AppTextStyle.semiBold16.copyWith(color: Colors.white)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666)),
        Text(
          value,
          style: AppTextStyle.medium14.copyWith(
            color: isGreen ? AppColor.reGreen00AF6C : AppColor.reBlack393939,
          ),
        ),
      ],
    );
  }

  void _applyPromoCode() {
    if (_promoCode.toUpperCase() == 'SAVE20') {
      setState(() {
        _discount = _subtotal * 0.2;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code applied! 20% off'),
          backgroundColor: AppColor.reGreen00AF6C,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid promo code'),
          backgroundColor: AppColor.reRedFF3B30,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Clear Cart', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
        content: Text(
          'Are you sure you want to remove all items from your cart?',
          style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTextStyle.medium14.copyWith(color: AppColor.reGrey666666)),
          ),
          TextButton(
            onPressed: () {
              setState(() => _cartItems.clear());
              Navigator.pop(context);
            },
            child: Text('Clear', style: AppTextStyle.medium14.copyWith(color: AppColor.reRedFF3B30)),
          ),
        ],
      ),
    );
  }
}
