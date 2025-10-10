import 'package:shared_preferences/shared_preferences.dart';

import 'storage_key.dart';

class LocalStorageService{
  static SharedPreferences? _prefs;

  // Ensure instance is initialized only once
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
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

  
  Future<Map<String, String>> getSavedLogins() async {
    final data = _prefs?.getString(StorageKey.savedLoginsKey.key);
    if (data == null || data.isEmpty) return {};
    final entries = data.split(";;");
    return {
      for (var e in entries)
        if (e.contains("||")) e.split("||")[0]: e.split("||")[1],
    };
  }

  
  Future<void> saveLogin(String email, String password) async {
    final logins = await getSavedLogins();
    logins[email] = password; // overwrite if exists
    final serialized =
        logins.entries.map((e) => "${e.key}||${e.value}").join(";;");
    await _prefs?.setString(StorageKey.savedLoginsKey.key, serialized);
  }

  
  Future<void> removeLogin(String email) async {
    final logins = await getSavedLogins();
    logins.remove(email);
    final serialized =
        logins.entries.map((e) => "${e.key}||${e.value}").join(";;");
    await _prefs?.setString(StorageKey.savedLoginsKey.key, serialized);
  }


}
