/// Enum to define all keys in a type-safe way
enum StorageKey { token, rememberMe, savedLoginsKey, languageCode, countryCode }

extension StorageKeyExtension on StorageKey {
  String get key {
    switch (this) {
      case StorageKey.token:
        return 'token';
      case StorageKey.rememberMe:
        return 'rememberMe';
      case StorageKey.savedLoginsKey:
        return "saved_logins";
      case StorageKey.languageCode:
        return 'langCode';
      case StorageKey.countryCode:
        return "countryCode";
    }
  }
}
