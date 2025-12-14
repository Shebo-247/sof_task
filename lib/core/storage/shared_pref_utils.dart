import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  /// Instance of shared preferences
  static SharedPreferences? _sharedPrefs;

  static Future<void> initialize() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  /// Reads the value for the key from common preferences storage
  static Future<T?> getCommon<T>(String key) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    try {
      if ('' is T) {
        return _sharedPrefs?.getString(key) as T?;
      } else if (0 is T) {
        return _sharedPrefs?.getInt(key) as T?;
      } else if (true is T) {
        return _sharedPrefs?.getBool(key) as T?;
      } else if (0.0 is T) {
        return _sharedPrefs?.getDouble(key) as T?;
      } else if (<String>[] is T) {
        return _sharedPrefs?.getStringList(key) as T?;
      } else {
        return _sharedPrefs?.get(key) as T?;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  /// Sets the value for the key to common preferences storage
  static Future<bool> setCommon<T>(String key, T value) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    if (value is String) {
      return _sharedPrefs!.setString(key, value);
    } else if (value is int) {
      return _sharedPrefs!.setInt(key, value);
    } else if (value is bool) {
      return _sharedPrefs!.setBool(key, value);
    } else if (value is double) {
      return _sharedPrefs!.setDouble(key, value);
    } else if (value is List<String>) {
      return _sharedPrefs!.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported type: $T');
    }
  }

  /// Erases common preferences keys
  static Future<bool> clearCommon() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    return _sharedPrefs!.clear();
  }

  static Future<bool> clearKey(String key) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    return _sharedPrefs!.remove(key);
  }
}
