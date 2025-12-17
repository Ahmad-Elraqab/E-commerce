import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/config/dynamic_colors.dart';
import 'package:taxi_client_app/data/models/config/navigation_config.dart';

/// Configurable bottom navigation that reads from JSON configuration
///
/// Features:
/// - Dynamic nav items from config
/// - Configurable order
/// - Show/hide items
/// - Customizable styling
/// - Badge support
class ConfigurableBottomNavigation extends StatefulWidget {
  const ConfigurableBottomNavigation({
    super.key,
    required this.width,
    required this.tabsRouter,
    this.onBadgeUpdate,
  });

  final double width;
  final TabsRouter tabsRouter;
  final Map<String, int>? Function()? onBadgeUpdate;

  @override
  State<ConfigurableBottomNavigation> createState() => _ConfigurableBottomNavigationState();
}

class _ConfigurableBottomNavigationState extends State<ConfigurableBottomNavigation> {
  late BottomNavConfig _navConfig;
  late List<NavItem> _navItems;
  Map<String, int> _badges = {};

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  void _loadConfig() {
    _navConfig = AppConfigService.instance.config.navigation.bottomNav;
    _navItems = _navConfig.enabledItems;

    // Get badge counts if callback provided
    if (widget.onBadgeUpdate != null) {
      _badges = widget.onBadgeUpdate!() ?? {};
    }
  }

  void onTap(int index) {
    widget.tabsRouter.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    if (!_navConfig.enabled || _navItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = DynamicColors.instance;
    final uiConfig = AppConfigService.instance.ui.bottomNav;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          boxShadow: [
            BoxShadow(color: colors.shadow.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -5)),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        width: widget.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(index, _navItems[index], colors, uiConfig),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, NavItem item, DynamicColors colors, dynamic uiConfig) {
    final isActive = widget.tabsRouter.activeIndex == index;
    final badgeCount = _badges[item.id] ?? 0;
    final showBadge = _navConfig.showBadges && badgeCount > 0;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isActive ? 20 : 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? colors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  isActive ? item.activeIconData : item.iconData,
                  color: isActive ? colors.primary : colors.textDisabled,
                  size: 24,
                ),
                if (showBadge)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(color: colors.error, borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          badgeCount > 9 ? '9+' : badgeCount.toString(),
                          style: TextStyle(color: colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isActive && _navConfig.showLabels) ...[
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: AppConfigService.instance.fontFamily,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Alternative bottom navigation styles
class BottomNavStyles {
  /// Modern style with expanding labels
  static Widget modern({required double width, required TabsRouter tabsRouter}) {
    return ConfigurableBottomNavigation(width: width, tabsRouter: tabsRouter);
  }

  /// Classic style with fixed items
  static Widget classic({
    required BuildContext context,
    required int currentIndex,
    required Function(int) onTap,
  }) {
    final navConfig = AppConfigService.instance.config.navigation.bottomNav;
    final navItems = navConfig.enabledItems;
    final colors = DynamicColors.instance;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surface,
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.textDisabled,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: navItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.iconData),
          activeIcon: Icon(item.activeIconData),
          label: item.label,
        );
      }).toList(),
    );
  }

  /// Material 3 style navigation bar
  static Widget material3({
    required BuildContext context,
    required int currentIndex,
    required Function(int) onTap,
  }) {
    final navConfig = AppConfigService.instance.config.navigation.bottomNav;
    final navItems = navConfig.enabledItems;
    final colors = DynamicColors.instance;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: colors.surface,
      indicatorColor: colors.primary.withOpacity(0.15),
      destinations: navItems.map((item) {
        return NavigationDestination(
          icon: Icon(item.iconData),
          selectedIcon: Icon(item.activeIconData, color: colors.primary),
          label: item.label,
        );
      }).toList(),
    );
  }
}
