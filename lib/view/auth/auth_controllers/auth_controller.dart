import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:geeta/core/services/token_storage.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_constants.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';
import 'package:geeta/core/services/firebase/notifications_service.dart';

/// مسؤول عن الجلسة والتوكنات (access token + fcm token)
/// يُسجّل مرة وحدة في main بـ permanent: true
class AuthController extends GetxController {
  final FirebaseAuthService _auth = Get.find();
  final FirestoreService _firestore = Get.find();
  final NotificationsService _notifications = Get.find();
  final TokenStorage _tokens = Get.find();

  StreamSubscription<String>? _fcmRefreshSub;
  StreamSubscription<String?>? _idTokenSub;

  bool get isLoggedIn => _auth.isLoggedIn;

  @override
  void onInit() {
    super.onInit();
    // لو المستخدم مسجل دخول من قبل: كمّل الجلسة
    if (_auth.isLoggedIn) {
      startTokenListeners();
      refreshAccessToken();
    }
  }

  // ================== Tokens ==================

  /// يجيب الـ access token (Firebase ID Token) ويخزنه محلياً
  Future<String?> refreshAccessToken({bool force = false}) async {
    final token = await _auth.getIdToken(forceRefresh: force);
    if (token != null && token.isNotEmpty) {
      await _tokens.updateAccessToken(token);
    }
    
    return token;
  }

  /// يحدّث الـ fcm token محلياً وعلى Firestore
  Future<void> updateFcmToken(String token) async {
    if (token.isEmpty) return;
    await _tokens.updateFcmToken(token);

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.setDocument(
      collectionPath: FirestoreCollections.users,
      documentId: uid,
      data: {'fcmToken': token},
      merge: true,
    );
  }

  /// يجيب التوكنين ويخزنهم محلياً، وبيرجع الـ fcm token لحفظه بـ Firestore
  Future<String?> syncTokens() async {
    await refreshAccessToken();
    final fcm = await _notifications.getToken();
    if (fcm != null && fcm.isNotEmpty) await _tokens.updateFcmToken(fcm);
    return fcm;
  }

  /// استماع للتجديد التلقائي للتوكنات
  void startTokenListeners() {
    stopTokenListeners();

    _fcmRefreshSub = _notifications.onTokenRefresh.listen(
      (token) => updateFcmToken(token).catchError(
        (e) => debugPrint('fcm refresh error: $e'),
      ),
    );

    _idTokenSub = _auth.idTokenChanges.listen((token) {
      if (token != null && token.isNotEmpty) {
        _tokens.updateAccessToken(token);
      }
    });
  }

  Future<void> stopTokenListeners() async {
    await _fcmRefreshSub?.cancel();
    await _idTokenSub?.cancel();
    _fcmRefreshSub = null;
    _idTokenSub = null;
  }

  // ================== Logout ==================

  Future<void> logout() async {
    await stopTokenListeners();

    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      try {
        // نحذف التوكن من السيرفر حتى ما توصل إشعارات لمستخدم خارج
        await _firestore.updateDocument(
          collectionPath: FirestoreCollections.users,
          documentId: uid,
          data: {'fcmToken': FieldValue.delete()},
        );
      } catch (e) {
        debugPrint('logout: remove fcm token failed: $e');
      }
    }

    await _notifications.deleteToken();
    await _tokens.clear();
    await _auth.logout();
  }

  @override
  void onClose() {
    stopTokenListeners();
    super.onClose();
  }
}