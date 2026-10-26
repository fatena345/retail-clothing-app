import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:geeta/model/user/user_model.dart';
import 'package:geeta/view/auth/auth_controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';

class RegisterController extends GetxController {
  final FirebaseAuthService _authService = Get.find();
  final FirestoreService _firestore = Get.find();
  final AuthController _session = Get.find();

  StatusClass status = StatusClass.initial;

  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    status = StatusClass.loading;
    update();

    // 1) Auth
    final result = await _authService.signUp(email: email, password: password);

    final user = result.fold((error) {
      status = error;
      return null;
    }, (credential) => credential.user);

    if (user == null) {
      if (status == StatusClass.loading) {
        status = StatusClass.anotherError(message: AppString.signupFailed);
      }
      update();
      return false;
    }

    // 2) Tokens + حفظ بيانات المستخدم
    try {
      final fcmToken = await _session.syncTokens();

      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? email.trim(),
        name: name.trim(),
        fcmToken: fcmToken,
      );

      await _firestore.setDocument(
        collectionPath: FirestoreCollections.users,
        documentId: user.uid,
        data: userModel.toCreateMap(),
      );

      _session.startTokenListeners();

      status = StatusClass.success;
      update();
      return true;
    } catch (e) {
      debugPrint('register error: $e');
      status = StatusClass.anotherError(message: AppString.signupFailed);
      update();
      return false;
    }
  }
}