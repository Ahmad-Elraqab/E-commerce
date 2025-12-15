import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';

@RoutePage()
class OrderDetailsView extends StatelessWidget {
  final String orderId;

  const OrderDetailsView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final order = _getOrderDetails();

    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(order),
            const SizedBox(height: 20),
            _buildTrackingSection(order),
            const SizedBox(height: 20),
            _buildShippingInfo(order),
            const SizedBox(height: 20),
            _buildOrderItems(order),
            const SizedBox(height: 20),
            _buildPaymentSummary(order),
            const SizedBox(height: 24),
            _buildActions(context, order),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getOrderDetails() {
    return {
      'id': orderId,
      'date': 'Dec 15, 2024',
      'status': 'In Transit',
      'statusColor': const Color(0xFF6C5CE7),
      'estimatedDelivery': 'Dec 18, 2024',
      'trackingNumber': 'TRK9876543210',
      'currentStep': 3,
      'shippingAddress': {
        'name': 'John Doe',
        'address': '123 Main Street, Apt 4B',
        'city': 'New York, NY 10001',
        'phone': '+1 (555) 123-4567',
      },
      'paymentMethod': 'Credit Card (**** 4242)',
      'items': [
        {
          'name': 'Wireless Bluetooth Headphones',
          'quantity': 1,
          'price': 129.99,
          'color': const Color(0xFF2D3436),
        },
        {'name': 'Smart Watch Series 5', 'quantity': 1, 'price': 299.00, 'color': const Color(0xFF6C5CE7)},
        {'name': 'Running Shoes Air Max', 'quantity': 2, 'price': 89.99, 'color': const Color(0xFF00B894)},
      ],
      'subtotal': 608.97,
      'shipping': 0.0,
      'tax': 48.72,
      'total': 657.69,
      'trackingHistory': [
        {
          'status': 'Order Placed',
          'date': 'Dec 15, 2024 10:30 AM',
          'description': 'Your order has been confirmed',
        },
        {
          'status': 'Processing',
          'date': 'Dec 15, 2024 2:45 PM',
          'description': 'Your order is being prepared',
        },
        {'status': 'Shipped', 'date': 'Dec 16, 2024 9:00 AM', 'description': 'Package left the warehouse'},
        {
          'status': 'In Transit',
          'date': 'Dec 17, 2024 3:30 PM',
          'description': 'Package is on its way to you',
        },
      ],
    };
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.reWhiteFFFFFF,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColor.reBlack393939, size: 20),
        onPressed: () => context.router.pop(),
      ),
      title: Text('Order Details', style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.help_outline, color: AppColor.reBlack393939),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildOrderHeader(Map<String, dynamic> order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order['id']}',
                    style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Placed on ${order['date']}',
                    style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: (order['statusColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order['status'],
                  style: AppTextStyle.semiBold14.copyWith(color: order['statusColor']),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.reOrangeFF9500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping_outlined, color: AppColor.reOrangeFF9500),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Delivery',
                        style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
                      ),
                      Text(
                        order['estimatedDelivery'],
                        style: AppTextStyle.semiBold16.copyWith(color: AppColor.reOrangeFF9500),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.reOrangeFF9500,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Track', style: AppTextStyle.semiBold12.copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingSection(Map<String, dynamic> order) {
    final trackingHistory = order['trackingHistory'] as List<Map<String, dynamic>>;

    return Container(
      padding: const EdgeInsets.all(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tracking', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
              Text(
                order['trackingNumber'],
                style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(trackingHistory.length, (index) {
            final step = trackingHistory[trackingHistory.length - 1 - index];
            final isFirst = index == 0;
            final isLast = index == trackingHistory.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isFirst ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                        shape: BoxShape.circle,
                      ),
                      child: isFirst ? const Icon(Icons.check, color: Colors.white, size: 10) : null,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 50,
                        color: isFirst ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['status'],
                        style: AppTextStyle.semiBold14.copyWith(
                          color: isFirst ? AppColor.reOrangeFF9500 : AppColor.reBlack393939,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step['description'],
                        style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step['date'],
                        style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey9C9C9C),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildShippingInfo(Map<String, dynamic> order) {
    final address = order['shippingAddress'] as Map<String, dynamic>;

    return Container(
      padding: const EdgeInsets.all(20),
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
          Text('Shipping Address', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.reOrangeFF9500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.location_on_outlined, color: AppColor.reOrangeFF9500),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address['name'],
                      style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939),
                    ),
                    Text(
                      address['address'],
                      style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                    ),
                    Text(
                      address['city'],
                      style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                    ),
                    Text(
                      address['phone'],
                      style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(Map<String, dynamic> order) {
    final items = order['items'] as List<Map<String, dynamic>>;

    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            'Order Items (${items.length})',
            style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.shopping_bag, color: (item['color'] as Color).withOpacity(0.5)),
                  ),
                  const SizedBox(width: 12),
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
                          'Qty: ${item['quantity']}',
                          style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                    style: AppTextStyle.semiBold16.copyWith(color: AppColor.reOrangeFF9500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(Map<String, dynamic> order) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text('Payment Summary', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.credit_card, color: AppColor.reGrey666666, size: 20),
              const SizedBox(width: 8),
              Text(
                order['paymentMethod'],
                style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPriceRow('Subtotal', '\$${order['subtotal'].toStringAsFixed(2)}'),
          _buildPriceRow(
            'Shipping',
            order['shipping'] == 0 ? 'Free' : '\$${order['shipping'].toStringAsFixed(2)}',
            isGreen: order['shipping'] == 0,
          ),
          _buildPriceRow('Tax', '\$${order['tax'].toStringAsFixed(2)}'),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
              Text(
                '\$${order['total'].toStringAsFixed(2)}',
                style: AppTextStyle.bold20.copyWith(color: AppColor.reOrangeFF9500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
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
      ),
    );
  }

  Widget _buildActions(BuildContext context, Map<String, dynamic> order) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColor.reOrangeFF9500),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Need Help?',
              style: AppTextStyle.semiBold14.copyWith(color: AppColor.reOrangeFF9500),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.reOrangeFF9500,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text('Reorder', style: AppTextStyle.semiBold14.copyWith(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
