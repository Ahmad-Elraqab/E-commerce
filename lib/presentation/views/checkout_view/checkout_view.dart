import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _currentStep = 0;
  int _selectedAddressIndex = 0;
  int _selectedPaymentIndex = 0;

  final List<Map<String, dynamic>> _addresses = [
    {
      'name': 'Home',
      'icon': Icons.home_outlined,
      'address': '123 Main Street, Apt 4B',
      'city': 'New York, NY 10001',
      'phone': '+1 (555) 123-4567',
      'isDefault': true,
    },
    {
      'name': 'Office',
      'icon': Icons.business_outlined,
      'address': '456 Business Ave, Floor 12',
      'city': 'New York, NY 10002',
      'phone': '+1 (555) 987-6543',
      'isDefault': false,
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Credit Card',
      'icon': Icons.credit_card,
      'details': '**** **** **** 4242',
      'color': const Color(0xFF667EEA),
    },
    {
      'name': 'PayPal',
      'icon': Icons.account_balance_wallet,
      'details': 'user@email.com',
      'color': const Color(0xFF00B894),
    },
    {'name': 'Apple Pay', 'icon': Icons.apple, 'details': 'Apple Pay', 'color': const Color(0xFF2D3436)},
  ];

  final List<Map<String, dynamic>> _orderItems = [
    {'name': 'Wireless Headphones', 'quantity': 1, 'price': 129.99},
    {'name': 'Smart Watch Series 5', 'quantity': 1, 'price': 299.00},
    {'name': 'Running Shoes Air Max', 'quantity': 2, 'price': 89.99},
  ];

  double get _subtotal => _orderItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  double get _shipping => _subtotal > 100 ? 0 : 9.99;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _shipping + _tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: _buildCurrentStep()),
          ),
          _buildBottomBar(),
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
        onPressed: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            context.router.pop();
          }
        },
      ),
      title: Text('Checkout', style: AppTextStyle.semiBold18.copyWith(color: AppColor.reBlack252525)),
      centerTitle: true,
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['Shipping', 'Payment', 'Review'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppColor.reWhiteFFFFFF,
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: index ~/ 2 < _currentStep ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
              ),
            );
          }
          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= _currentStep;
          final isCompleted = stepIndex < _currentStep;
          return Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isActive ? AppColor.reOrangeFF9500 : AppColor.reGreyD7D7D7,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : Text(
                          '${stepIndex + 1}',
                          style: AppTextStyle.semiBold14.copyWith(
                            color: isActive ? Colors.white : AppColor.reGrey666666,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[stepIndex],
                style: AppTextStyle.medium12.copyWith(
                  color: isActive ? AppColor.reOrangeFF9500 : AppColor.reGrey666666,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildShippingStep();
      case 1:
        return _buildPaymentStep();
      case 2:
        return _buildReviewStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildShippingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Address', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: AppColor.reOrangeFF9500, size: 18),
              label: Text('Add New', style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(_addresses.length, (index) => _buildAddressCard(_addresses[index], index)),
        const SizedBox(height: 24),
        // Delivery Options
        Text('Delivery Options', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
        const SizedBox(height: 16),
        _buildDeliveryOption(
          'Standard Delivery',
          '5-7 business days',
          _shipping == 0 ? 'Free' : '\$9.99',
          true,
        ),
        _buildDeliveryOption('Express Delivery', '2-3 business days', '\$19.99', false),
        _buildDeliveryOption('Same Day Delivery', 'Today', '\$29.99', false),
      ],
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    final isSelected = _selectedAddressIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedAddressIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColor.reOrangeFF9500 : Colors.transparent, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.reOrangeFF9500.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(address['icon'], color: AppColor.reOrangeFF9500),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        address['name'],
                        style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939),
                      ),
                      if (address['isDefault']) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColor.reOrangeFF9500.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Default',
                            style: AppTextStyle.medium10.copyWith(color: AppColor.reOrangeFF9500),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address['address'],
                    style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                  ),
                  Text(address['city'], style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666)),
                  const SizedBox(height: 4),
                  Text(
                    address['phone'],
                    style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack4D4D4D),
                  ),
                ],
              ),
            ),
            Radio<int>(
              value: index,
              groupValue: _selectedAddressIndex,
              onChanged: (value) => setState(() => _selectedAddressIndex = value!),
              activeColor: AppColor.reOrangeFF9500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption(String title, String subtitle, String price, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? AppColor.reOrangeFF9500 : Colors.transparent, width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.local_shipping_outlined, color: AppColor.reOrangeFF9500),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.semiBold14.copyWith(color: AppColor.reBlack393939)),
                Text(subtitle, style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666)),
              ],
            ),
          ),
          Text(
            price,
            style: AppTextStyle.semiBold16.copyWith(
              color: price == 'Free' ? AppColor.reGreen00AF6C : AppColor.reBlack393939,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Payment Method', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: AppColor.reOrangeFF9500, size: 18),
              label: Text('Add New', style: AppTextStyle.medium14.copyWith(color: AppColor.reOrangeFF9500)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(_paymentMethods.length, (index) => _buildPaymentCard(_paymentMethods[index], index)),
        const SizedBox(height: 24),
        // Security Note
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.reGreen00AF6C.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.security, color: AppColor.reGreen00AF6C),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Secure Payment',
                      style: AppTextStyle.semiBold14.copyWith(color: AppColor.reGreen00AF6C),
                    ),
                    Text(
                      'Your payment information is encrypted and secure.',
                      style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment, int index) {
    final isSelected = _selectedPaymentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColor.reOrangeFF9500 : Colors.transparent, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (payment['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(payment['icon'], color: payment['color']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payment['name'],
                    style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack393939),
                  ),
                  Text(
                    payment['details'],
                    style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                  ),
                ],
              ),
            ),
            Radio<int>(
              value: index,
              groupValue: _selectedPaymentIndex,
              onChanged: (value) => setState(() => _selectedPaymentIndex = value!),
              activeColor: AppColor.reOrangeFF9500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shipping Address Summary
        _buildSummaryCard('Shipping Address', Icons.location_on_outlined, [
          _addresses[_selectedAddressIndex]['name'],
          _addresses[_selectedAddressIndex]['address'],
          _addresses[_selectedAddressIndex]['city'],
        ]),
        const SizedBox(height: 16),
        // Payment Method Summary
        _buildSummaryCard('Payment Method', Icons.payment_outlined, [
          _paymentMethods[_selectedPaymentIndex]['name'],
          _paymentMethods[_selectedPaymentIndex]['details'],
        ]),
        const SizedBox(height: 24),
        // Order Items
        Text('Order Items', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.reWhiteFFFFFF,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              ..._orderItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item['name']} x${item['quantity']}',
                          style: AppTextStyle.regular14.copyWith(color: AppColor.reBlack393939),
                        ),
                      ),
                      Text(
                        '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                        style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              _buildPriceRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
              _buildPriceRow(
                'Shipping',
                _shipping == 0 ? 'Free' : '\$${_shipping.toStringAsFixed(2)}',
                isGreen: _shipping == 0,
              ),
              _buildPriceRow('Tax', '\$${_tax.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
                  Text(
                    '\$${_total.toStringAsFixed(2)}',
                    style: AppTextStyle.bold20.copyWith(color: AppColor.reOrangeFF9500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, IconData icon, List<String> details) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.reOrangeFF9500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColor.reOrangeFF9500),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.semiBold14.copyWith(color: AppColor.reGrey666666)),
                const SizedBox(height: 4),
                ...details.map(
                  (detail) =>
                      Text(detail, style: AppTextStyle.medium14.copyWith(color: AppColor.reBlack393939)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _currentStep = title.contains('Shipping') ? 0 : 1),
            icon: Icon(Icons.edit_outlined, color: AppColor.reOrangeFF9500, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              if (_currentStep < 2) {
                setState(() => _currentStep++);
              } else {
                _placeOrder();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.reOrangeFF9500,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: Text(
              _currentStep == 2 ? 'Place Order' : 'Continue',
              style: AppTextStyle.semiBold16.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.reGreen00AF6C.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: AppColor.reGreen00AF6C, size: 48),
              ),
              const SizedBox(height: 24),
              Text('Order Placed!', style: AppTextStyle.bold24.copyWith(color: AppColor.reBlack252525)),
              const SizedBox(height: 8),
              Text(
                'Your order has been placed successfully.\nOrder ID: #ORD12345',
                style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.router.pushAndPopUntil(
                      const OrdersView(),
                      predicate: (route) => route.settings.name == MainView.name,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.reOrangeFF9500,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('View Orders', style: AppTextStyle.semiBold16.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.router.popUntil((route) => route.settings.name == MainView.name);
                },
                child: Text(
                  'Continue Shopping',
                  style: AppTextStyle.medium14.copyWith(color: AppColor.reGrey666666),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
