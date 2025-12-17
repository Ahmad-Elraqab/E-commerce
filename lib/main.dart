import 'package:taxi_client_app/app/app.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/env/env.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration from JSON
  await AppConfigService.instance.initialize(configPath: 'lib/app/config/app_config.json');

  runApp(App(env: EnvironmentConfig.dev));
}
