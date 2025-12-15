import 'package:taxi_client_app/app/di/app_dependencies.dart';
import 'package:taxi_client_app/app/env/env.dart';
import 'package:taxi_client_app/app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key, required this.env});
  final EnvironmentConfig env;
  // final _router = router.Router(authGuard: AuthGuard.instance);
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: AppDependencies.of(context, env).providers, child: _MaterialApp(_router));
  }
}

class _MaterialApp extends StatefulWidget {
  const _MaterialApp(this._router);

  final AppRouter _router;

  @override
  State<_MaterialApp> createState() => __MaterialAppState();
}

class __MaterialAppState extends State<_MaterialApp> {
  @override
  Widget build(BuildContext context) {
    // final navigator = ExtendedNavigator.ofRouter<YourRouterName>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, _) => MaterialApp.router(
        title: 'App',
        routeInformationParser: widget._router.defaultRouteParser(),
        routerDelegate: widget._router.delegate(navigatorObservers: () => []),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
