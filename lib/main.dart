import 'package:taxi_client_app/app/app.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/env/env.dart';
import 'package:taxi_client_app/core/di/injection_container.dart' as di;
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Clean Architecture Dependency Injection
  await di.init();

  // Initialize app configuration from JSON
  await AppConfigService.instance.initialize(configPath: 'lib/app/config/app_config.json');

  runApp(App(env: EnvironmentConfig.dev));
}
