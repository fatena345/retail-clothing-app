import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager extends GetxService {
  static StorageManager? _manager;
  static SharedPreferences? _pref;

  StorageManager._();

  static Future<StorageManager> getInstance() async {
    _manager ??= StorageManager._();
    _pref ??= await SharedPreferences.getInstance();
    return _manager!;
  }

  // save data method -- support any type of values
  Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    _pref ??= await SharedPreferences.getInstance();

    if (value is String) {
      await _pref!.setString(key, value);
    } else if (value is int) {
      await _pref!.setInt(key, value);
    } else if (value is bool) {
      await _pref!.setBool(key, value);
    } else if (value is double) {
      await _pref!.setDouble(key, value);
    } else if (value is List<String>) {
      await _pref!.setStringList(key, value);
    } else {
      throw Exception('Unsupported type: ${value.runtimeType}');
    }
  }

  // get string data
  Future<dynamic> getData({required String key}) async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref?.getString(key);
  }

  // get string list data
  Future<List<String>?> getStringList({required String key}) async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref?.getStringList(key);
  }

  // remove data
  Future<bool> removeData({required String key}) async {
    _pref ??= await SharedPreferences.getInstance();
    return await _pref!.remove(key);
  }
}