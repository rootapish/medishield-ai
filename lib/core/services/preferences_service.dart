import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<String?> getString(String key) async {
    await initialize();
    return _prefs!.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    await initialize();
    return _prefs!.setString(key, value);
  }

  Future<bool?> getBool(String key) async {
    await initialize();
    return _prefs!.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    await initialize();
    return _prefs!.setBool(key, value);
  }
}
