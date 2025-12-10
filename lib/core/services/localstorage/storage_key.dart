/// Enum to define all keys in a type-safe way
enum StorageKey {
  token,
  rememberMe,
  savedLoginsKey,
  languageCode,
  postalCode,
  isUserOnboardingCompleated,
  isDealerOnBoardingCompleated,
}

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
      case StorageKey.postalCode:
        return "postalCode";
      case StorageKey.isUserOnboardingCompleated:
        return "onboardinguser";
      case StorageKey.isDealerOnBoardingCompleated:
        return "onboardingdealer";
    }
  }
}
