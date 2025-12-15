import 'package:taxi_client_app/app/app_view_models/app_view_model.dart';
import 'package:taxi_client_app/app/env/app_color.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/widgets/bottom_navigation.dart';

@RoutePage()
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    // context.read<UserViewModel>().checkToken(
    //   onError: (val) {
    //     context.router.pushAndPopUntil(LoginView(), predicate: (route) => route.settings.name == 'Main');
    //   },
    //   onSuccess: (val) {
    //     print("Valid session");
    //   },
    // );
    // checkSession();
    super.initState();
  }

  // Future<void> checkSession() async {
  //   final token = await context.read<AuthTokenStorage>().getToken();
  //   final user = await context.read<FlutterSecureStorage>().read(key: 'user');

  //   if (token == null) {
  //     // ignore: use_build_context_synchronously
  //     context.router.replace(const LoginView());
  //   } else {
  //     context.read<UserViewModel>().user =
  //         UserModel.fromJson(json.decode(user.toString()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.reWhiteFFFFFF,
      body: AutoTabsRouter(
        lazyLoad: true,
        routes: const [HomeView(), CategoriesView(), OrdersView(), ProfileView()],
        homeIndex: 0,
        builder: (context, child) {
          context.read<AppViewModel>().tabsRouter = AutoTabsRouter.of(context);

          return Stack(
            children: [
              child,
              BottomNavigation(width: width, tabsRouter: context.watch<AppViewModel>().tabsRouter!),
            ],
          );
        },
      ),
    );
  }
}
