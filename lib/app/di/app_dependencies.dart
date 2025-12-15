import 'package:taxi_client_app/app/app_view_models/app_view_model.dart';
import 'package:taxi_client_app/app/data_sources/local_storage/auth_token_secure_storage.dart';
import 'package:taxi_client_app/app/data_sources/local_storage/auth_token_shared_prefs.dart';
import 'package:taxi_client_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:taxi_client_app/app/data_sources/remote/rest_service.dart';
import 'package:taxi_client_app/app/data_sources/shared_preferences_wrapper.dart';
import 'package:taxi_client_app/app/env/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  AppDependencies._({required this.context, required this.env});

  final BuildContext context;
  final EnvironmentConfig env;

  static AppDependencies? _instance;

  factory AppDependencies.of(context, env) => _instance ?? AppDependencies._(context: context, env: env);

  List<SingleChildWidget> get providers => [
    ..._dataStorages,
    ..._dataSources,
    ..._analytics,
    ..._httpClients,
    ..._repositories,
    ..._useCases,
    ..._providers,
    ..._interceptors,
  ];

  List<ChangeNotifierProvider> get _providers => [
    ChangeNotifierProvider<AppViewModel>(create: (context) => AppViewModel()),
  ];
  List<Provider> get _analytics => [];
  List<Provider> get _httpClients => [
    Provider<Dio>(create: (context) => Dio()),
    Provider<RestService>(create: (context) => RestService(baseUrl: env.baseApiUrl)),
    // Provider<AttendanceService>(
    //   create: (context) => AttendanceService(
    //     localStorage: context.read(),
    //     restService: context.read(),
    //   ),
    // ),
  ];
  List<Provider> get _dataStorages => [
    // Provider<CacheClient>(create: (context) => CacheClient()),
    Provider<SharedPreferencesWrapper>(create: (context) => SharedPreferencesWrapper()),

    Provider<FlutterSecureStorage>(create: (context) => const FlutterSecureStorage()),
  ];
  List<Provider> get _dataSources => [
    Provider<AuthTokenStorage>(
      create: (context) => kIsWeb
          ? AuthTokenSharedPrefs(context.read<SharedPreferencesWrapper>())
          : AuthTokenSecureStorage(context.read<FlutterSecureStorage>()),
    ),
  ];
  List<Provider> get _repositories => [];
  List<Provider> get _useCases => [];
  List<Provider> get _interceptors => [];
}
