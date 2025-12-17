import 'package:taxi_client_app/app/app_view_models/app_view_model.dart';
import 'package:taxi_client_app/app/config/dynamic_colors.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';
import 'package:taxi_client_app/app/widgets/configurable_bottom_navigation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  // Provide badge counts for navigation items
  Map<String, int>? _getBadgeCounts() {
    // You can connect this to your state management
    // to provide real badge counts
    return {'cart': 2, 'notifications': 3};
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final colors = DynamicColors.instance;

    return Scaffold(
      backgroundColor: colors.surface,
      body: AutoTabsRouter(
        lazyLoad: true,
        routes: const [HomeView(), CategoriesView(), OrdersView(), ProfileView()],
        homeIndex: 0,
        builder: (context, child) {
          context.read<AppViewModel>().tabsRouter = AutoTabsRouter.of(context);

          return Stack(
            children: [
              child,
              ConfigurableBottomNavigation(
                width: width,
                tabsRouter: context.watch<AppViewModel>().tabsRouter!,
                onBadgeUpdate: _getBadgeCounts,
              ),
            ],
          );
        },
      ),
    );
  }
}
