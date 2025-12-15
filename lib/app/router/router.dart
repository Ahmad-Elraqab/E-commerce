// For every changes made in router, run the below command:
// `flutter pub run build_runner build --delete-conflicting-outputs`

import 'package:taxi_client_app/app/router/router.gr.dart';
import 'package:taxi_client_app/app/router/user_guard.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(deferredLoading: true, replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    // Splash
    AutoRoute(initial: true, page: SplashView.page, path: '/splash'),

    // Auth Routes
    AutoRoute(page: LoginView.page, path: '/login'),
    AutoRoute(page: RegisterView.page, path: '/register'),

    // Main App with Bottom Navigation
    AutoRoute(
      guards: [AuthGuard.init()],
      page: MainView.page,
      path: '/',
      children: [
        // Bottom Navigation Tabs
        AutoRoute(initial: true, page: HomeView.page, path: 'home', maintainState: false),
        AutoRoute(page: CategoriesView.page, path: 'categories'),
        AutoRoute(page: OrdersView.page, path: 'orders'),
        AutoRoute(page: ProfileView.page, path: 'profile'),
      ],
    ),

    // Standalone Routes (outside bottom navigation)
    AutoRoute(page: ProductsView.page, path: '/products'),
    AutoRoute(page: ProductDetailsView.page, path: '/product/:productId'),
    AutoRoute(page: CartView.page, path: '/cart'),
    AutoRoute(page: CheckoutView.page, path: '/checkout'),
    AutoRoute(page: OrderDetailsView.page, path: '/order/:orderId'),
    AutoRoute(page: WishlistView.page, path: '/wishlist'),
    AutoRoute(page: SearchView.page, path: '/search'),
  ];
}
