import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.width, required this.tabsRouter});

  final double width;
  final TabsRouter tabsRouter;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void onTap(index) async {
    widget.tabsRouter.setActiveIndex(index);
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
    {'icon': Icons.grid_view_outlined, 'activeIcon': Icons.grid_view, 'label': 'Categories'},
    {'icon': Icons.receipt_long_outlined, 'activeIcon': Icons.receipt_long, 'label': 'Orders'},
    {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.reWhiteFFFFFF,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -5)),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        width: widget.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) => _buildNavItem(index, _navItems[index])),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, Map<String, dynamic> item) {
    final isActive = widget.tabsRouter.activeIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isActive ? 20 : 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColor.reOrangeFF9500.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item['activeIcon'] : item['icon'],
              color: isActive ? AppColor.reOrangeFF9500 : AppColor.reGrey9C9C9C,
              size: 24,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                item['label'],
                style: TextStyle(
                  color: AppColor.reOrangeFF9500,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
