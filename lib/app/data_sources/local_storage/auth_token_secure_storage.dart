import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_token_storage.dart';

/// Concrete implementation of AuthTokenDataSource using FlutterSecureStorage.
/// Suitable for mobile.
/// Persist and get auth information to make it  available trough the app.
class AuthTokenSecureStorage implements AuthTokenStorage {
  AuthTokenSecureStorage(this._storage);

  final FlutterSecureStorage _storage;

  /// Get stored access token
  @override
  Future<String?> getToken() => _storage.read(key: StorageKeys.token);

  @override
  Future<String?> getGuestToken() => _storage.read(key: StorageKeys.guestToken);

  /// Persist access token
  @override
  Future<void> saveToken(String newToken) =>
      _storage.write(key: StorageKeys.token, value: newToken);

  /// Get stored refresh token
  @override
  Future<String?> getRefreshToken() =>
      _storage.read(key: StorageKeys.refreshToken);

  /// Persist new refresh token
  @override
  Future<void> saveRefreshToken(String newRefreshToken) =>
      _storage.write(key: StorageKeys.refreshToken, value: newRefreshToken);

  /// Delete all saved data
  @override
  Future<void> clear() => _storage.deleteAll();
}
