import 'package:taxi_client_app/services/user_service.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required this.service});

  UserService service;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    Future.microtask(() => notifyListeners());
  }

  // UserModel? _user;

  // UserModel? get user => _user;

  // set user(UserModel? value) {
  //   print(value!.toJson());
  //   Future.microtask(() {
  //     _user = value;
  //   });
  // }

  // TextEditingController serverUrl = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  // bool isValidEmail(String email) {
  //   final RegExp emailRegex = RegExp(
  //     r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  //   );

  //   return emailRegex.hasMatch(email);
  // }

  // bool isValidPassword(String password) {
  //   final RegExp passwordRegex = RegExp(
  //     r'^.{7,}$',
  //   );
  //   return passwordRegex.hasMatch(password);
  // }

  // bool isValidName(String name) {
  //   final RegExp passwordRegex = RegExp(
  //     r'^.{5,}$',
  //   );
  //   return passwordRegex.hasMatch(name);
  // }

  // Future<void> validateForm(email, password, onError, resume) async {
  //   if (!isValidEmail(email)) {
  //     onError("requires a valid email");
  //   } else if (!isValidPassword(password)) {
  //     onError("password must be at least 8 characters");
  //   } else {
  //     await resume();
  //   }
  // }

  // Future<void> validateSingUpForm(
  //     email, password, name, onError, resume) async {
  //   if (!isValidEmail(email)) {
  //     onError("requires a valid email");
  //   } else if (!isValidPassword(password)) {
  //     onError("password must be at least 8 characters");
  //   } else if (!isValidName(name)) {
  //     onError("name must be at least 5 characters");
  //   } else {
  //     await resume();
  //   }
  // }

  // Future<void> checkToken({
  //   required Function onSuccess,
  //   required Function onError,
  // }) async {
  //   try {
  //     await service.checkToken();
  //     onSuccess('');
  //   } catch (e) {
  //     loading = false;
  //     if (e is RestException) {
  //       onError(e.responseMessage);
  //     } else {
  //       onError("something went wrong!");
  //     }
  //   }
  // }

  // Future<void> login({
  //   required Function onSuccess,
  //   required Function onError,
  // }) async {
  //   try {
  //     await validateForm(emailController.text, passwordController.text, onError,
  //         () async {
  //       loading = true;
  //       user = await service.login(
  //           username: emailController.text, password: passwordController.text);

  //       notifyListeners();
  //       onSuccess("Login Successfully");
  //       loading = false;
  //     });
  //     // onSuccess("");
  //   } catch (e) {
  //     loading = false;
  //     if (e is RestException) {
  //       onError(e.responseMessage);
  //     } else {
  //       onError("something went wrong!");
  //     }
  //   }
  // }

  // Future<void> refreshToken() async {}

  // Future<void> logout() async {
  //   user = null;
  //   await service.logout();
  // }

  // Future<void> checkLogged() async {}

  // Future<void> addMobile(
  //     {required Function onSuccess, required Function onError}) async {
  //   try {
  //     loading = true;
  //     var deviceId = await _getId();
  //     service.addMobile(
  //       email: user!.email.toString(),
  //       macAddress: deviceId.toString(),
  //     );
  //     loading = false;
  //   } catch (e) {
  //     loading = false;
  //     if (e is RestException) {
  //       onError(e.responseMessage);
  //     } else {
  //       onError("something went wrong!");
  //     }
  //   }
  // }

  // Future<void> resetPassword(
  //     {required String email, required String password}) async {
  //   // service.resetPassword(password: password, email: email);
  // }
  // Future<String?> _getId() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else if (Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.id; // unique ID on Android
  //   }
  // }
}
