import 'package:flutter/material.dart';

/// Navigation configuration model
class NavigationConfig {
  final BottomNavConfig bottomNav;
  final AppBarConfig appBar;
  final DrawerConfig drawer;

  const NavigationConfig({required this.bottomNav, required this.appBar, required this.drawer});

  factory NavigationConfig.fromJson(Map<String, dynamic> json) {
    return NavigationConfig(
      bottomNav: BottomNavConfig.fromJson(json['bottomNav'] ?? {}),
      appBar: AppBarConfig.fromJson(json['appBar'] ?? {}),
      drawer: DrawerConfig.fromJson(json['drawer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'bottomNav': bottomNav.toJson(),
    'appBar': appBar.toJson(),
    'drawer': drawer.toJson(),
  };

  factory NavigationConfig.defaults() {
    return NavigationConfig(
      bottomNav: BottomNavConfig.defaults(),
      appBar: AppBarConfig.defaults(),
      drawer: DrawerConfig.defaults(),
    );
  }
}

/// Bottom navigation configuration
class BottomNavConfig {
  final bool enabled;
  final String style;
  final bool showLabels;
  final bool showBadges;
  final List<NavItem> items;

  const BottomNavConfig({
    required this.enabled,
    required this.style,
    required this.showLabels,
    required this.showBadges,
    required this.items,
  });

  factory BottomNavConfig.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    return BottomNavConfig(
      enabled: json['enabled'] ?? true,
      style: json['style'] ?? 'modern',
      showLabels: json['showLabels'] ?? true,
      showBadges: json['showBadges'] ?? true,
      items: itemsList.map((item) => NavItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'style': style,
    'showLabels': showLabels,
    'showBadges': showBadges,
    'items': items.map((item) => item.toJson()).toList(),
  };

  factory BottomNavConfig.defaults() {
    return BottomNavConfig(
      enabled: true,
      style: 'modern',
      showLabels: true,
      showBadges: true,
      items: [
        NavItem.defaults(id: 'home', label: 'Home', icon: 'home_outlined', activeIcon: 'home', order: 1),
        NavItem.defaults(
          id: 'categories',
          label: 'Categories',
          icon: 'grid_view_outlined',
          activeIcon: 'grid_view',
          order: 2,
        ),
        NavItem.defaults(
          id: 'orders',
          label: 'Orders',
          icon: 'receipt_long_outlined',
          activeIcon: 'receipt_long',
          order: 3,
        ),
        NavItem.defaults(
          id: 'profile',
          label: 'Profile',
          icon: 'person_outline',
          activeIcon: 'person',
          order: 4,
        ),
      ],
    );
  }

  /// Get enabled items sorted by order
  List<NavItem> get enabledItems {
    return items.where((item) => item.enabled).toList()..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Get the index of a nav item by id
  int getIndexById(String id) {
    final enabledList = enabledItems;
    for (int i = 0; i < enabledList.length; i++) {
      if (enabledList[i].id == id) return i;
    }
    return 0;
  }
}

/// Navigation item configuration
class NavItem {
  final String id;
  final String label;
  final String icon;
  final String activeIcon;
  final String route;
  final bool enabled;
  final int order;
  final String? badge;

  const NavItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
    required this.enabled,
    required this.order,
    this.badge,
  });

  factory NavItem.fromJson(Map<String, dynamic> json) {
    return NavItem(
      id: json['id'] ?? '',
      label: json['label'] ?? '',
      icon: json['icon'] ?? '',
      activeIcon: json['activeIcon'] ?? json['icon'] ?? '',
      route: json['route'] ?? '',
      enabled: json['enabled'] ?? true,
      order: json['order'] ?? 0,
      badge: json['badge'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'icon': icon,
    'activeIcon': activeIcon,
    'route': route,
    'enabled': enabled,
    'order': order,
    'badge': badge,
  };

  factory NavItem.defaults({
    required String id,
    required String label,
    required String icon,
    required String activeIcon,
    required int order,
  }) {
    return NavItem(
      id: id,
      label: label,
      icon: icon,
      activeIcon: activeIcon,
      route: '/$id',
      enabled: true,
      order: order,
    );
  }

  /// Get the icon data for the inactive state
  IconData get iconData => _getIconData(icon);

  /// Get the icon data for the active state
  IconData get activeIconData => _getIconData(activeIcon);

  /// Convert icon string to IconData
  static IconData _getIconData(String iconName) {
    return _iconMap[iconName] ?? Icons.help_outline;
  }

  /// Icon name to IconData mapping
  static const Map<String, IconData> _iconMap = {
    'home': Icons.home,
    'home_outlined': Icons.home_outlined,
    'home_filled': Icons.home,
    'grid_view': Icons.grid_view,
    'grid_view_outlined': Icons.grid_view_outlined,
    'category': Icons.category,
    'category_outlined': Icons.category_outlined,
    'apps': Icons.apps,
    'apps_outlined': Icons.apps_outlined,
    'receipt_long': Icons.receipt_long,
    'receipt_long_outlined': Icons.receipt_long_outlined,
    'receipt': Icons.receipt,
    'receipt_outlined': Icons.receipt_outlined,
    'list_alt': Icons.list_alt,
    'list_alt_outlined': Icons.list_alt_outlined,
    'person': Icons.person,
    'person_outline': Icons.person_outline,
    'account_circle': Icons.account_circle,
    'account_circle_outlined': Icons.account_circle_outlined,
    'shopping_cart': Icons.shopping_cart,
    'shopping_cart_outlined': Icons.shopping_cart_outlined,
    'shopping_bag': Icons.shopping_bag,
    'shopping_bag_outlined': Icons.shopping_bag_outlined,
    'favorite': Icons.favorite,
    'favorite_border': Icons.favorite_border,
    'favorite_outlined': Icons.favorite_outline,
    'search': Icons.search,
    'search_outlined': Icons.search_outlined,
    'notifications': Icons.notifications,
    'notifications_outlined': Icons.notifications_outlined,
    'notifications_none': Icons.notifications_none,
    'settings': Icons.settings,
    'settings_outlined': Icons.settings_outlined,
    'more_horiz': Icons.more_horiz,
    'more_vert': Icons.more_vert,
    'menu': Icons.menu,
    'chat': Icons.chat,
    'chat_outlined': Icons.chat_outlined,
    'help': Icons.help,
    'help_outline': Icons.help_outline,
    'info': Icons.info,
    'info_outline': Icons.info_outline,
    'logout': Icons.logout,
    'login': Icons.login,
    'explore': Icons.explore,
    'explore_outlined': Icons.explore_outlined,
    'location_on': Icons.location_on,
    'location_on_outlined': Icons.location_on_outlined,
    'wallet': Icons.account_balance_wallet,
    'wallet_outlined': Icons.account_balance_wallet_outlined,
    'payment': Icons.payment,
    'payment_outlined': Icons.payment_outlined,
    'history': Icons.history,
    'star': Icons.star,
    'star_outline': Icons.star_outline,
  };
}

/// App bar configuration
class AppBarConfig {
  final bool showBackButton;
  final bool showLogo;
  final bool showSearch;
  final bool showCart;
  final bool showNotifications;
  final bool centerTitle;
  final double elevation;

  const AppBarConfig({
    required this.showBackButton,
    required this.showLogo,
    required this.showSearch,
    required this.showCart,
    required this.showNotifications,
    required this.centerTitle,
    required this.elevation,
  });

  factory AppBarConfig.fromJson(Map<String, dynamic> json) {
    return AppBarConfig(
      showBackButton: json['showBackButton'] ?? true,
      showLogo: json['showLogo'] ?? false,
      showSearch: json['showSearch'] ?? true,
      showCart: json['showCart'] ?? true,
      showNotifications: json['showNotifications'] ?? true,
      centerTitle: json['centerTitle'] ?? true,
      elevation: (json['elevation'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'showBackButton': showBackButton,
    'showLogo': showLogo,
    'showSearch': showSearch,
    'showCart': showCart,
    'showNotifications': showNotifications,
    'centerTitle': centerTitle,
    'elevation': elevation,
  };

  factory AppBarConfig.defaults() {
    return const AppBarConfig(
      showBackButton: true,
      showLogo: false,
      showSearch: true,
      showCart: true,
      showNotifications: true,
      centerTitle: true,
      elevation: 0,
    );
  }
}

/// Drawer configuration
class DrawerConfig {
  final bool enabled;
  final bool showHeader;
  final bool showUserInfo;
  final List<DrawerItem> items;

  const DrawerConfig({
    required this.enabled,
    required this.showHeader,
    required this.showUserInfo,
    required this.items,
  });

  factory DrawerConfig.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    return DrawerConfig(
      enabled: json['enabled'] ?? false,
      showHeader: json['showHeader'] ?? true,
      showUserInfo: json['showUserInfo'] ?? true,
      items: itemsList.map((item) => DrawerItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'showHeader': showHeader,
    'showUserInfo': showUserInfo,
    'items': items.map((item) => item.toJson()).toList(),
  };

  factory DrawerConfig.defaults() {
    return const DrawerConfig(enabled: false, showHeader: true, showUserInfo: true, items: []);
  }
}

/// Drawer item configuration
class DrawerItem {
  final String id;
  final String label;
  final String icon;
  final String route;
  final bool enabled;
  final int order;

  const DrawerItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
    required this.enabled,
    required this.order,
  });

  factory DrawerItem.fromJson(Map<String, dynamic> json) {
    return DrawerItem(
      id: json['id'] ?? '',
      label: json['label'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
      enabled: json['enabled'] ?? true,
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'icon': icon,
    'route': route,
    'enabled': enabled,
    'order': order,
  };

  IconData get iconData => NavItem._getIconData(icon);
}
