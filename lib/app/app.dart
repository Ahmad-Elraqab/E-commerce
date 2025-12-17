import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/config/app_theme.dart';
import 'package:taxi_client_app/app/di/app_dependencies.dart';
import 'package:taxi_client_app/app/env/env.dart';
import 'package:taxi_client_app/app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key, required this.env});
  final EnvironmentConfig env;
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
  late AppTheme _appTheme;

  @override
  void initState() {
    super.initState();
    _appTheme = AppTheme();

    // Listen for config changes to rebuild theme
    AppConfigService.instance.addListener(_onConfigChanged);
  }

  @override
  void dispose() {
    AppConfigService.instance.removeListener(_onConfigChanged);
    super.dispose();
  }

  void _onConfigChanged() {
    setState(() {
      _appTheme = AppTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appInfo = AppConfigService.instance.appInfo;
    final themeConfig = AppConfigService.instance.config.theme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, _) => MaterialApp.router(
        title: appInfo.name,
        theme: _appTheme.lightTheme,
        darkTheme: themeConfig.supportDarkMode ? _appTheme.darkTheme : null,
        themeMode: themeConfig.isDark ? ThemeMode.dark : ThemeMode.light,
        routeInformationParser: widget._router.defaultRouteParser(),
        routerDelegate: widget._router.delegate(navigatorObservers: () => []),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
