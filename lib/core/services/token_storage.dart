import 'package:geeta/core/constants/app_constants.dart';
import 'package:geeta/core/constants/app_keys.dart';
import 'package:geeta/core/services/storage_manager.dart';
import 'package:get/get.dart';

class TokenStorage extends GetxService {
  TokenStorage(this._storage);

  final StorageManager _storage;

  /// تحميل التوكنات من التخزين المحلي للـ cache عند تشغيل التطبيق
  Future<TokenStorage> init() async {
    AppConstants.accessToken =
        _storage.getData<String>(key: AppKeys.accessToken) ?? '';
    AppConstants.fcmToken =
        _storage.getData<String>(key: AppKeys.fcmToken) ?? '';
    return this;
  }

  // ---------------- Access Token ----------------
  Future<void> updateAccessToken(String token) async {
    AppConstants.accessToken = token;
    await _storage.saveData(key: AppKeys.accessToken, value: token);
  }

  String get accessToken => AppConstants.accessToken;

  // ---------------- FCM Token ----------------
  Future<void> updateFcmToken(String token) async {
    AppConstants.fcmToken = token;
    await _storage.saveData(key: AppKeys.fcmToken, value: token);
  }

  String get fcmToken => AppConstants.fcmToken;

  // ---------------- Clear ----------------
  Future<void> clear() async {
    AppConstants.accessToken = '';
    AppConstants.fcmToken = '';
    await _storage.removeData(key: AppKeys.accessToken);
    await _storage.removeData(key: AppKeys.fcmToken);
  }
}