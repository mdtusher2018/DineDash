import 'package:shared_preferences/shared_preferences.dart';
import 'storage_key.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;
  static bool isUserOnboardingCompleated = false;
  static bool isDealerOnBoardingCompleated = false;

  // Ensure instance is initialized only once
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    isUserOnboardingCompleated =
        _prefs?.getBool(StorageKey.isUserOnboardingCompleated.key) ?? false;
    isDealerOnBoardingCompleated =
        _prefs?.getBool(StorageKey.isDealerOnBoardingCompleated.key) ?? false;
  }

  Future<void> saveString(StorageKey key, String value) async {
    await _prefs?.setString(key.key, value);
  }

  Future<String?> getString(StorageKey key) async {
    return _prefs?.getString(key.key);
  }

  Future<void> saveBool(StorageKey key, bool value) async {
    await _prefs?.setBool(key.key, value);
  }

  Future<bool?> getBool(StorageKey key) async {
    return _prefs?.getBool(key.key);
  }

  Future<void> remove(StorageKey key) async {
    await _prefs?.remove(key.key);
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }

  Future<void> clearAllExceptOnboarding() async {
    final keys = _prefs?.getKeys().toList() ?? [];

    for (final key in keys) {
      // skip only onboarding keys
      if (key == StorageKey.isUserOnboardingCompleated.key ||
          key == StorageKey.isDealerOnBoardingCompleated.key) {
        continue;
      }
      await _prefs?.remove(key);
    }
  }
}
