/// Persist and get auth information in/from data source
/// so this information will be available trough the app
abstract class AuthTokenStorage {
  static bool tokenIsEmpty = true;

  /// Get stored access token
  Future<String?> getToken();

  /// Get stored access token
  Future<String?> getGuestToken();

  /// Persist access token
  Future<void> saveToken(String newToken);

  /// Get stored refresh token
  Future<String?> getRefreshToken();

  /// Persist new refresh token
  Future<void> saveRefreshToken(String newRefreshToken);

  /// Delete all saved data
  Future<void> clear();
}

class StorageKeys {
  static const guestToken = 'guestToken';
  static const token = 'token';
  static const refreshToken = 'refreshToken';
}
