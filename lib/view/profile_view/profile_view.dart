import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/env/text_style.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.reGreyF9F9F9,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildStatsSection()),
          SliverToBoxAdapter(child: _buildQuickActions(context)),
          SliverToBoxAdapter(child: _buildMenuSection(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.reOrangeFF9500, AppColor.reOrangeFF9500.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                    onPressed: () => context.router.pop(),
                  ),
                  Text('Profile', style: AppTextStyle.semiBold18.copyWith(color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Profile Info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor: AppColor.reOrangeFF9500.withOpacity(0.2),
                          child: Text(
                            'JD',
                            style: AppTextStyle.bold32.copyWith(color: AppColor.reOrangeFF9500),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                          ),
                          child: Icon(Icons.camera_alt, color: AppColor.reOrangeFF9500, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('John Doe', style: AppTextStyle.bold24.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    'johndoe@email.com',
                    style: AppTextStyle.regular14.copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text('Gold Member', style: AppTextStyle.semiBold12.copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.reWhiteFFFFFF,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('12', 'Orders', Icons.shopping_bag_outlined),
          _buildDivider(),
          _buildStatItem('5', 'Wishlist', Icons.favorite_border),
          _buildDivider(),
          _buildStatItem('\$2.5K', 'Spent', Icons.account_balance_wallet_outlined),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColor.reOrangeFF9500, size: 24),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyle.bold20.copyWith(color: AppColor.reBlack252525)),
        Text(label, style: AppTextStyle.regular12.copyWith(color: AppColor.reGrey666666)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 50, color: AppColor.reGreyEEEEEE);
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              context,
              'My Orders',
              Icons.receipt_long_outlined,
              const Color(0xFF6C5CE7),
              () => context.router.push(const OrdersView()),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              context,
              'Wishlist',
              Icons.favorite_outline,
              const Color(0xFFE84393),
              () => context.router.push(const WishlistView()),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              context,
              'Addresses',
              Icons.location_on_outlined,
              const Color(0xFF00B894),
              () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyle.medium12.copyWith(color: AppColor.reBlack393939),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Account Settings',
              style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack252525),
            ),
          ),
          _buildMenuItem(context, 'Edit Profile', Icons.person_outline, onTap: () {}),
          _buildMenuItem(context, 'Payment Methods', Icons.credit_card, onTap: () {}),
          _buildMenuItem(
            context,
            'Notifications',
            Icons.notifications_outlined,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: AppColor.reRedFF3B30, borderRadius: BorderRadius.circular(12)),
              child: Text('3', style: AppTextStyle.bold10.copyWith(color: Colors.white)),
            ),
            onTap: () {},
          ),
          _buildMenuItem(context, 'Security', Icons.security, onTap: () {}),
          _buildMenuItem(
            context,
            'Language',
            Icons.language,
            trailing: Text('English', style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666)),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Support', style: AppTextStyle.semiBold16.copyWith(color: AppColor.reBlack252525)),
          ),
          _buildMenuItem(context, 'Help Center', Icons.help_outline, onTap: () {}),
          _buildMenuItem(context, 'About Us', Icons.info_outline, onTap: () {}),
          _buildMenuItem(context, 'Terms & Conditions', Icons.description_outlined, onTap: () {}),
          _buildMenuItem(context, 'Privacy Policy', Icons.privacy_tip_outlined, onTap: () {}),
          const SizedBox(height: 8),
          _buildMenuItem(
            context,
            'Log Out',
            Icons.logout,
            iconColor: AppColor.reRedFF3B30,
            textColor: AppColor.reRedFF3B30,
            showDivider: false,
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon, {
    Color? iconColor,
    Color? textColor,
    Widget? trailing,
    bool showDivider = true,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (iconColor ?? AppColor.reOrangeFF9500).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor ?? AppColor.reOrangeFF9500, size: 20),
          ),
          title: Text(
            title,
            style: AppTextStyle.medium14.copyWith(color: textColor ?? AppColor.reBlack393939),
          ),
          trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.reGrey9C9C9C),
          onTap: onTap,
        ),
        if (showDivider) Divider(height: 1, indent: 72, endIndent: 16, color: AppColor.reGreyEEEEEE),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Log Out', style: AppTextStyle.bold18.copyWith(color: AppColor.reBlack252525)),
        content: Text(
          'Are you sure you want to log out?',
          style: AppTextStyle.regular14.copyWith(color: AppColor.reGrey666666),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTextStyle.medium14.copyWith(color: AppColor.reGrey666666)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.router.pushAndPopUntil(const LoginView(), predicate: (route) => false);
            },
            child: Text('Log Out', style: AppTextStyle.medium14.copyWith(color: AppColor.reRedFF3B30)),
          ),
        ],
      ),
    );
  }
}
