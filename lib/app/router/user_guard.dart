import 'package:taxi_client_app/app/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthGuard extends AutoRouteGuard {
  factory AuthGuard.init() {
    return _instance;
  }
  AuthGuard._internal();

  static final AuthGuard _instance = AuthGuard._internal();

  static AuthGuard get instance => _instance;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // const pref = FlutterSecureStorage();

    // final user = await pref.read(key: 'token');

    // print("User Token: $user");

    // if (user != null) {
    //   resolver.next(true);
    // } else {
    //   await router.root.push(const LoginView());
    // }
    resolver.next(true);
  }

  Future<void> onProtectedCallback(StackRouter router, {required void Function() onSuccess}) async {}
}

class BookingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);
  }
}
