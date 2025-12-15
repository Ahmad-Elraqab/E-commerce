import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

  Future<String?> getString(String key) async =>
      (await _instance).getString(key);

  Future<bool> setString(String key, String value) async =>
      (await _instance).setString(key, value);

  Future<bool> clear() async => (await _instance).clear();
}
