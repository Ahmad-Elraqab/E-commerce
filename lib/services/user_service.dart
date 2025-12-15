import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taxi_client_app/app/data_sources/local_storage/auth_token_storage.dart';
import 'package:taxi_client_app/app/data_sources/remote/rest_service.dart';
import 'package:taxi_client_app/app/data_sources/shared_preferences_wrapper.dart';
import 'package:dio/dio.dart';

class UserService {
  UserService({
    required this.restService,
    required this.localStorage,
    required this.storage,
    required this.sharedPreferences,
  });

  final RestService restService;
  final AuthTokenStorage localStorage;
  final FlutterSecureStorage storage;
  final SharedPreferencesWrapper sharedPreferences;

  // Future<bool> isLoggedIn() async {
  //   final token = await localStorage.getToken();
  //   if (token != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future<bool> checkToken() async {
  //   try {
  //     final token = await localStorage.getToken();

  //     var headers = {'Cookie': 'sid=$token;'};

  //     final response = await restService.dio.get(
  //       'https://dev.qatarat-alnada.com/api/method/flow_branding.api.mobile_api.get_attendance_list_by_user',
  //       options: Options(method: 'GET', headers: headers),
  //     );

  //     if (response.statusCode != 200) {
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } catch (e) {
  //     // print(e);
  //     rethrow;
  //   }
  // }

  // Future<UserModel> login({required String username, required String password}) async {
  //   try {
  //     final response = await restService.dio.post("/api/method/login?usr=$username&pwd=$password&=");

  //     final UserModel user = UserModel.fromJson(response.data);

  //     // return user;
  //     await localStorage.saveToken(user.sid.toString());
  //     // await storage.write(key: 'id', value: response.data['user_id']);

  //     await storage.write(key: 'user', value: json.encode(user.toJson()));

  //     return user;
  //   } catch (e) {
  //     // print(e);
  //     rethrow;
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     await localStorage.clear();
  //     await restService.dio.post("/api/method/logout?all_session=1");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> refreshToken() async {
  //   final token = await localStorage.getToken();

  //   try {
  //     if (token != null) {
  //       final response = await restService.dio.get("/api/refreshToken");

  //       await localStorage.saveToken(response.data['data']);
  //     }
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<void> addMobile({required String email, required String macAddress}) async {
  //   final token = await localStorage.getToken();

  //   try {
  //     if (token != null) {
  //       final response = await restService.dio.get(
  //         "/api/method/flow_branding.api.mobile_api.add_user_mobile?user=$email&mac_address=$macAddress&device_token",
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //       } else {
  //         throw 'Device already exists';
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
