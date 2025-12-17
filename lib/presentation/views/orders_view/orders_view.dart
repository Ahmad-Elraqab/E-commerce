import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD12345',
      'date': 'Dec 15, 2024',
      'status': 'Delivered',
      'statusColor': const Color(0xFF00B894),
      'total': 518.97,
      'items': 3,
      'trackingSteps': 4,
    },
    {
      'id': 'ORD12344',
      'date': 'Dec 10, 2024',
      'status': 'In Transit',
      'statusColor': const Color(0xFF6C5CE7),
      'total': 299.00,
      'items': 1,
      'trackingSteps': 3,
    },
    {
      'id': 'ORD12343',
      'date': 'Dec 5, 2024',
      'status': 'Processing',
      'statusColor': const Color(0xFFFDAA5D),
      'total': 89.99,
      'items': 2,
      'trackingSteps': 2,
    },
    {
      'id': 'ORD12342',
      'date': 'Nov 28, 2024',
      'status': 'Delivered',
      'statusColor': const Color(0xFF00B894),
      'total': 429.98,
      'items': 4,
      'trackingSteps': 4,
    },
    {
      'id': 'ORD12341',
      'date': 'Nov 20, 2024',
      'status': 'Cancelled',
      'statusColor': const Color(0xFFFF7675),
      'total': 149.00,
      'items': 1,
      'trackingSteps': 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _activeOrders =>
      _orders.where((o) => o['status'] != 'Delivered' && o['status'] != 'Cancelled').toList();

  List<Map<String, dynamic>> get _completedOrders =>
      _orders.where((o) => o['status'] == 'Delivered').toList();

  List<Map<String, dynamic>> get _cancelledOrders =>
      _orders.where((o) => o['status'] == 'Cancelled').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(_activeOrders, 'No active orders'),
                _buildOrdersList(_completedOrders, 'No completed orders'),
                _buildOrdersList(_cancelledOrders, 'No cancelled orders'),
              ],
            ),
          ),
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
      title: Text('My Orders', style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525)),
      centerTitle: true,
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColor.reWhiteFFFFFF,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColor.reOrangeFF9500,
        unselectedLabelColor: AppColor.reGrey666666,
        labelStyle: AppTextStyle.semiBold14,
        unselectedLabelStyle: AppTextStyle.medium14,
        indicatorColor: AppColor.reOrangeFF9500,
        indicatorWeight: 3,
        tabs: [
          Tab(text: 'Active (${_activeOrders.length})'),
          Tab(text: 'Completed (${_completedOrders.length})'),
          Tab(text: 'Cancelled (${_cancelledOrders.length})'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 80, color: AppColor.reGreyD7D7D7),
            const SizedBox(height: 16),
            Text(emptyMessage, style: AppTextStyle.medium16.copyWith(color: AppColor.reGrey666666)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(orders[index]),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () => context.router.push(OrderDetailsView(orderId: order['id'])),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order['id']}',
                        style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack252525),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['date'],
                        style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: (order['statusColor'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order['status'],
                      style: AppTextStyle.semiBold12.copyWith(color: order['statusColor']),
                    ),
                  ),
                ],
              ),
            ),
            // Progress Indicator (for active orders)
            if (order['status'] != 'Cancelled' && order['status'] != 'Delivered')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildProgressIndicator(order['trackingSteps']),
              ),
            // Divider
            Divider(color: AppColor.reGreyEEEEEE),
            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order['items']} item${order['items'] > 1 ? 's' : ''}',
                        style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                      ),
                      Text(
                        '\$${order['total'].toStringAsFixed(2)}',
                        style: AppTextStyle.bold18.copyWith(color: AppColor.reOrangeFF9500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (order['status'] == 'Delivered')
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColor.reOrangeFF9500),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'Reorder',
                            style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.reGrey666666),
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

  Widget _buildProgressIndicator(int currentStep) {
    final steps = ['Confirmed', 'Shipped', 'Out for Delivery', 'Delivered'];
    return Column(
      children: [
        Row(
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Expanded(
                child: Container(
                  height: 3,
                  color: index ~/ 2 < currentStep ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                ),
              );
            }
            final stepIndex = index ~/ 2;
            return Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: stepIndex < currentStep ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps
              .map((step) => Text(step, style: AppTextStyle.regular10.copyWith(color: AppColor.reGrey666666)))
              .toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
