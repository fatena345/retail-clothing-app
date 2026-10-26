import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:geeta/model/user/user_model.dart';
import 'package:geeta/view/auth/auth_controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/constants/app_constants.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';

class ProfileController extends GetxController {
  final FirebaseAuthService _auth = Get.find();
  final FirestoreService _firestore = Get.find();
  final AuthController _session = Get.find();

  StreamSubscription<Map<String, dynamic>?>? _sub;

  UserModel? profile;
  StatusClass status = StatusClass.loading;
  bool isLoggingOut = false;

  @override
  void onInit() {
    super.onInit();
    _watchProfile();
  }

  void _watchProfile() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      status = StatusClass.noData;
      update();
      return;
    }

    _sub = _firestore
        .watchDocument(
          collectionPath: FirestoreCollections.users,
          documentId: uid,
        )
        .listen(
      (data) {
        if (data == null) {
          status = StatusClass.noData;
        } else {
          profile = UserModel.fromMap(data);
          status = StatusClass.success;
        }
        update();
      },
      onError: (e) {
        debugPrint('profile stream error: $e');
        status = StatusClass.anotherError(message: 'تعذر تحميل البيانات');
        update();
      },
    );
  }

  Future<void> logout() async {
    if (isLoggingOut) return;
    isLoggingOut = true;
    update();

    try {
      await _sub?.cancel(); // قبل signOut حتى ما يجي permission-denied
      _sub = null;
      await _session.logout();
      Get.offAllNamed(AppRoutes.welcome);
    } catch (e) {
      debugPrint('logout error: $e');
      isLoggingOut = false;
      update();
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}