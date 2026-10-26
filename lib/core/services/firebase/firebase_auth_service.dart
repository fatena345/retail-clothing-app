import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/constants/app_string.dart';

class FirebaseAuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => currentUser != null;

  /// يراقب تغيّر حالة تسجيل الدخول
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<Either<StatusClass, UserCredential>> signUp({
    required String email,
    required String password,
  }) {
    return _guard(
      'signUp',
      () => _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  Future<Either<StatusClass, UserCredential>> login({
    required String email,
    required String password,
  }) {
    return _guard(
      'login',
      () => _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  /// الـ ID Token (هو الـ access token). forceRefresh لتجديده
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      return await currentUser?.getIdToken(forceRefresh);
    } catch (e) {
      debugPrint('getIdToken error: $e');
      return null;
    }
  }

  /// يستمع لتجديد الـ ID Token تلقائياً (كل ~ساعة)
  Stream<String?> get idTokenChanges =>
      _auth.idTokenChanges().asyncMap((user) => user?.getIdToken());

  Future<void> logout() => _auth.signOut();

  // ---------- helper لتجنب تكرار try/catch ----------
  Future<Either<StatusClass, T>> _guard<T>(
    String tag,
    Future<T> Function() action,
  ) async {
    try {
      return Right(await action());
    } on FirebaseAuthException catch (e) {
      debugPrint('$tag error: ${e.code}');
      return Left(StatusClass.anotherError(message: e.message ?? e.code));
    } catch (e) {
      debugPrint('$tag error: $e');
      return Left(StatusClass.anotherError(message: AppString.wrong));
    }
  }
}