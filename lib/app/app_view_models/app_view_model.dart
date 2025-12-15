import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  AppViewModel();

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  set loggedIn(bool value) {
    _loggedIn = value;
    Future.microtask(() => notifyListeners());
  }

  TabsRouter? _tabsRouter;

  // ignore: unnecessary_getters_setters
  TabsRouter? get tabsRouter => _tabsRouter;

  set tabsRouter(TabsRouter? value) {
    _tabsRouter = value;
  }
}
