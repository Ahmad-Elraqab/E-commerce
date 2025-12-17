// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:taxi_client_app/presentation/views/auth/login_view.dart'
    deferred as _i5;
import 'package:taxi_client_app/presentation/views/auth/register_view.dart'
    deferred as _i12;
import 'package:taxi_client_app/presentation/views/cart_view/cart_view.dart'
    deferred as _i1;
import 'package:taxi_client_app/presentation/views/categories_view/categories_view.dart'
    deferred as _i2;
import 'package:taxi_client_app/presentation/views/checkout_view/checkout_view.dart'
    deferred as _i3;
import 'package:taxi_client_app/presentation/views/home_view/home_view.dart'
    deferred as _i4;
import 'package:taxi_client_app/presentation/views/main_view.dart'
    deferred as _i6;
import 'package:taxi_client_app/presentation/views/order_details_view/order_details_view.dart'
    deferred as _i7;
import 'package:taxi_client_app/presentation/views/orders_view/orders_view.dart'
    deferred as _i8;
import 'package:taxi_client_app/presentation/views/product_details_view/product_details_view.dart'
    deferred as _i9;
import 'package:taxi_client_app/presentation/views/products_view/products_view.dart'
    deferred as _i10;
import 'package:taxi_client_app/presentation/views/profile_view/profile_view.dart'
    deferred as _i11;
import 'package:taxi_client_app/presentation/views/search_view/search_view.dart'
    deferred as _i13;
import 'package:taxi_client_app/presentation/views/splash_view/splash_view.dart'
    deferred as _i14;
import 'package:taxi_client_app/presentation/views/vendors_view/vendor_details_view.dart'
    deferred as _i15;
import 'package:taxi_client_app/presentation/views/vendors_view/vendors_view.dart'
    deferred as _i16;
import 'package:taxi_client_app/presentation/views/wishlist_view/wishlist_view.dart'
    deferred as _i17;

abstract class $AppRouter extends _i18.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    CartView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.CartView(),
        ),
      );
    },
    CategoriesView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.CategoriesView(),
        ),
      );
    },
    CheckoutView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.CheckoutView(),
        ),
      );
    },
    HomeView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.HomeView(),
        ),
      );
    },
    LoginView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.LoginView(),
        ),
      );
    },
    MainView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.MainView(),
        ),
      );
    },
    OrderDetailsView.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsViewArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i7.loadLibrary,
          () => _i7.OrderDetailsView(
            key: args.key,
            orderId: args.orderId,
          ),
        ),
      );
    },
    OrdersView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.OrdersView(),
        ),
      );
    },
    ProductDetailsView.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsViewArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i9.loadLibrary,
          () => _i9.ProductDetailsView(
            key: args.key,
            productId: args.productId,
          ),
        ),
      );
    },
    ProductsView.name: (routeData) {
      final args = routeData.argsAs<ProductsViewArgs>(
          orElse: () => const ProductsViewArgs());
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.ProductsView(
            key: args.key,
            category: args.category,
          ),
        ),
      );
    },
    ProfileView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.ProfileView(),
        ),
      );
    },
    RegisterView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i12.loadLibrary,
          () => _i12.RegisterView(),
        ),
      );
    },
    SearchView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.SearchView(),
        ),
      );
    },
    SplashView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i14.loadLibrary,
          () => _i14.SplashView(),
        ),
      );
    },
    VendorDetailsView.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VendorDetailsViewArgs>(
          orElse: () =>
              VendorDetailsViewArgs(handle: pathParams.getString('handle')));
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i15.loadLibrary,
          () => _i15.VendorDetailsView(
            key: args.key,
            handle: args.handle,
          ),
        ),
      );
    },
    VendorsView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i16.loadLibrary,
          () => _i16.VendorsView(),
        ),
      );
    },
    WishlistView.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.DeferredWidget(
          _i17.loadLibrary,
          () => _i17.WishlistView(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CartView]
class CartView extends _i18.PageRouteInfo<void> {
  const CartView({List<_i18.PageRouteInfo>? children})
      : super(
          CartView.name,
          initialChildren: children,
        );

  static const String name = 'CartView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CategoriesView]
class CategoriesView extends _i18.PageRouteInfo<void> {
  const CategoriesView({List<_i18.PageRouteInfo>? children})
      : super(
          CategoriesView.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CheckoutView]
class CheckoutView extends _i18.PageRouteInfo<void> {
  const CheckoutView({List<_i18.PageRouteInfo>? children})
      : super(
          CheckoutView.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeView]
class HomeView extends _i18.PageRouteInfo<void> {
  const HomeView({List<_i18.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginView]
class LoginView extends _i18.PageRouteInfo<void> {
  const LoginView({List<_i18.PageRouteInfo>? children})
      : super(
          LoginView.name,
          initialChildren: children,
        );

  static const String name = 'LoginView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MainView]
class MainView extends _i18.PageRouteInfo<void> {
  const MainView({List<_i18.PageRouteInfo>? children})
      : super(
          MainView.name,
          initialChildren: children,
        );

  static const String name = 'MainView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i7.OrderDetailsView]
class OrderDetailsView extends _i18.PageRouteInfo<OrderDetailsViewArgs> {
  OrderDetailsView({
    _i19.Key? key,
    required String orderId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          OrderDetailsView.name,
          args: OrderDetailsViewArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsView';

  static const _i18.PageInfo<OrderDetailsViewArgs> page =
      _i18.PageInfo<OrderDetailsViewArgs>(name);
}

class OrderDetailsViewArgs {
  const OrderDetailsViewArgs({
    this.key,
    required this.orderId,
  });

  final _i19.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailsViewArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i8.OrdersView]
class OrdersView extends _i18.PageRouteInfo<void> {
  const OrdersView({List<_i18.PageRouteInfo>? children})
      : super(
          OrdersView.name,
          initialChildren: children,
        );

  static const String name = 'OrdersView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ProductDetailsView]
class ProductDetailsView extends _i18.PageRouteInfo<ProductDetailsViewArgs> {
  ProductDetailsView({
    _i19.Key? key,
    required String productId,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ProductDetailsView.name,
          args: ProductDetailsViewArgs(
            key: key,
            productId: productId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsView';

  static const _i18.PageInfo<ProductDetailsViewArgs> page =
      _i18.PageInfo<ProductDetailsViewArgs>(name);
}

class ProductDetailsViewArgs {
  const ProductDetailsViewArgs({
    this.key,
    required this.productId,
  });

  final _i19.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductDetailsViewArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i10.ProductsView]
class ProductsView extends _i18.PageRouteInfo<ProductsViewArgs> {
  ProductsView({
    _i19.Key? key,
    String? category,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ProductsView.name,
          args: ProductsViewArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsView';

  static const _i18.PageInfo<ProductsViewArgs> page =
      _i18.PageInfo<ProductsViewArgs>(name);
}

class ProductsViewArgs {
  const ProductsViewArgs({
    this.key,
    this.category,
  });

  final _i19.Key? key;

  final String? category;

  @override
  String toString() {
    return 'ProductsViewArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i11.ProfileView]
class ProfileView extends _i18.PageRouteInfo<void> {
  const ProfileView({List<_i18.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RegisterView]
class RegisterView extends _i18.PageRouteInfo<void> {
  const RegisterView({List<_i18.PageRouteInfo>? children})
      : super(
          RegisterView.name,
          initialChildren: children,
        );

  static const String name = 'RegisterView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SearchView]
class SearchView extends _i18.PageRouteInfo<void> {
  const SearchView({List<_i18.PageRouteInfo>? children})
      : super(
          SearchView.name,
          initialChildren: children,
        );

  static const String name = 'SearchView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SplashView]
class SplashView extends _i18.PageRouteInfo<void> {
  const SplashView({List<_i18.PageRouteInfo>? children})
      : super(
          SplashView.name,
          initialChildren: children,
        );

  static const String name = 'SplashView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i15.VendorDetailsView]
class VendorDetailsView extends _i18.PageRouteInfo<VendorDetailsViewArgs> {
  VendorDetailsView({
    _i19.Key? key,
    required String handle,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          VendorDetailsView.name,
          args: VendorDetailsViewArgs(
            key: key,
            handle: handle,
          ),
          rawPathParams: {'handle': handle},
          initialChildren: children,
        );

  static const String name = 'VendorDetailsView';

  static const _i18.PageInfo<VendorDetailsViewArgs> page =
      _i18.PageInfo<VendorDetailsViewArgs>(name);
}

class VendorDetailsViewArgs {
  const VendorDetailsViewArgs({
    this.key,
    required this.handle,
  });

  final _i19.Key? key;

  final String handle;

  @override
  String toString() {
    return 'VendorDetailsViewArgs{key: $key, handle: $handle}';
  }
}

/// generated route for
/// [_i16.VendorsView]
class VendorsView extends _i18.PageRouteInfo<void> {
  const VendorsView({List<_i18.PageRouteInfo>? children})
      : super(
          VendorsView.name,
          initialChildren: children,
        );

  static const String name = 'VendorsView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i17.WishlistView]
class WishlistView extends _i18.PageRouteInfo<void> {
  const WishlistView({List<_i18.PageRouteInfo>? children})
      : super(
          WishlistView.name,
          initialChildren: children,
        );

  static const String name = 'WishlistView';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}
