// import 'package:flutter/material.dart';
// import 'package:kinito_app/app/env/env.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';

// class MockAppDependencies {
//   MockAppDependencies._({
//     required this.context,
//     required this.env,
//   });

//   final BuildContext context;
//   final EnvironmentConfig env;

//   static MockAppDependencies? _instance;

//   factory MockAppDependencies.of(context, env) =>
//       _instance ?? MockAppDependencies._(context: context, env: env);

//   List<SingleChildWidget> get providers => [
//         ..._analytics,
//         ..._httpClients,
//         ..._dataStorages,
//         ..._dataSources,
//         ..._repositories,
//         ..._useCases,
//         ..._providers,
//         ..._interceptors,
//       ];

//   List<ChangeNotifierProvider> get _providers => [];
//   List<Provider> get _analytics => [];
//   List<Provider> get _httpClients => [];
//   List<Provider> get _dataStorages => [];
//   List<Provider> get _dataSources => [];
//   List<Provider> get _repositories => [];
//   List<Provider> get _useCases => [];
//   List<Provider> get _interceptors => [];
// }
