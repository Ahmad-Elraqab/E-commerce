import 'package:taxi_client_app/app/data_sources/shared_preferences_wrapper.dart';

import 'auth_token_storage.dart';

/// Concrete implementation of AuthTokenDataSource using SharedPreferences.
/// Suitable for mobile and web.
/// Persist and get auth information to make it  available trough the app.
class AuthTokenSharedPrefs implements AuthTokenStorage {
  AuthTokenSharedPrefs(SharedPreferencesWrapper storage) : _storage = storage;

  final SharedPreferencesWrapper _storage;

  /// Get stored access token
  @override
  Future<String?> getGuestToken() => _storage.getString(StorageKeys.guestToken);

  @override
  Future<String?> getToken() => _storage.getString(StorageKeys.token);

  /// Persist access token
  @override
  Future<bool> saveToken(String newToken) => _storage.setString(StorageKeys.token, newToken);

  /// Get stored refresh token
  @override
  Future<String?> getRefreshToken() => _storage.getString(StorageKeys.refreshToken);

  /// Persist new refresh token
  @override
  Future<bool> saveRefreshToken(String newRefreshToken) =>
      _storage.setString(StorageKeys.refreshToken, newRefreshToken);

  /// Delete all saved data
  @override
  Future<bool> clear() async => _storage.clear();
}
