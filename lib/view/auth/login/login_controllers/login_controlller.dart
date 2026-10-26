import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/enum.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:geeta/core/services/firebase/notifications_service.dart';
import 'package:geeta/view/auth/auth_controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';

class LoginController extends GetxController {
  final FirebaseAuthService _authService = Get.find();
  final FirestoreService _firestore = Get.find();
  final AuthController _session = Get.find();
  final NotificationsService _notifications = Get.find();
  bool rememberMe = false;
  StatusClass status = StatusClass.initial;

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    update();
  }

  Future<bool> login({required String email, required String password}) async {
    status = StatusClass.loading;
    update();

    // 1) Auth
    final result = await _authService.login(email: email, password: password);

    final user = result.fold((error) {
      status = error;
      return null;
    }, (credential) => credential.user);

    if (user == null) {
      if (status == StatusClass.loading) {
        status = StatusClass.anotherError(message: AppString.loginFailed);
      }
      update();
      return false;
    }

    // 2) Tokens + Firestore
    try {
      final fcmToken = await _session.syncTokens();

      // merge:true حتى ما نمسح باقي بيانات المستخدم
      await _firestore.setDocument(
        collectionPath: FirestoreCollections.users,
        documentId: user.uid,
        data: {
          'uid': user.uid,
          'email': user.email,
          'fcmToken': ?fcmToken,
        },
        merge: true,
      );

      _session.startTokenListeners();

      final profile = await _firestore.getDocument(
  collectionPath: FirestoreCollections.users,
  documentId: user.uid,
);

await _notifications.showLocal(
  title: AppString.loginSuccessTitle,
  body: AppString.loginSuccessBody(profile?['name'] as String?),
  data: {'type': 'account'},
  channel: AppNotificationChannel.account,
);

      status = StatusClass.success;
      update();
      return true;
    } catch (e) {
      debugPrint('login error: $e');
      status = StatusClass.anotherError(message: AppString.loginFailed);
      update();
      return false;
    }
  }
}