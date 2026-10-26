import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager extends GetxService {
  late final SharedPreferences _pref;

 
  Future<StorageManager> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    switch (value) {
      case String v:
        await _pref.setString(key, v);
      case int v:
        await _pref.setInt(key, v);
      case bool v:
        await _pref.setBool(key, v);
      case double v:
        await _pref.setDouble(key, v);
      case List<String> v:
        await _pref.setStringList(key, v);
      default:
        throw UnsupportedError('Unsupported type: ${value.runtimeType}');
    }
  }

  T? getData<T>({required String key}) {
    final value = _pref.get(key);
    return value is T ? value : null;
  }

  List<String>? getStringList({required String key}) =>
      _pref.getStringList(key);

  Future<bool> removeData({required String key}) => _pref.remove(key);

  Future<bool> clear() => _pref.clear();
}