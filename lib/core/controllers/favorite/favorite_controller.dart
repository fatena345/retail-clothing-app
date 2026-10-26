import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';
import 'package:geeta/model/product/product_model.dart';

class FavoriteController extends GetxController {
  final FirebaseAuthService _auth = Get.find();
  final FirestoreService _firestore = Get.find();

  StreamSubscription<User?>? _authSub;
  StreamSubscription<List<Map<String, dynamic>>>? _favSub;

  List<ProductModel> favoriteList = [];
  final Set<String> _ids = {}; // للتحقق السريع O(1)
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    // بيطلق قيمة فورية بالحالة الحالية، فبيغطي حالة "التطبيق فتح والمستخدم مسجل"
    _authSub = _auth.authStateChanges.listen(_onAuthChanged);
  }

  // ================== Session ==================
  void _onAuthChanged(User? user) {
    _favSub?.cancel();
    _favSub = null;

    if (user == null) {
      _setFavorites([]);
      isLoading = false;
      update();
      return;
    }

    isLoading = true;
    update();

    _favSub = _firestore
        .watchCollection(
          collectionPath: FirestoreCollections.favorites(user.uid),
          query: (q) => q.orderBy('addedAt', descending: true),
        )
        .listen(
      (data) {
        _setFavorites(data.map(ProductModel.fromMap).toList());
        isLoading = false;
        update();
      },
      onError: (e) {
        debugPrint('favorites stream error: $e');
        isLoading = false;
        update();
      },
    );
  }

  void _setFavorites(List<ProductModel> list) {
    favoriteList = list;
    _ids
      ..clear()
      ..addAll(list.map((p) => p.id));
  }

  // ================== Queries ==================
  bool isFavorite(String productId) => _ids.contains(productId);

  // ================== Actions ==================
  Future<void> toggleFavorite(ProductModel product) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      Get.snackbar('Favorite', 'سجّل دخولك أولاً');
      return;
    }

    final path = FirestoreCollections.favorites(uid);
    final wasFavorite = isFavorite(product.id);

    try {
      if (wasFavorite) {
        await _firestore.deleteDocument(
          collectionPath: path,
          documentId: product.id,
        );
      } else {
        await _firestore.setDocument(
          collectionPath: path,
          documentId: product.id,
          data: {
            ...product.toUpdateMap(),
            'addedAt': FieldValue.serverTimestamp(),
          },
        );
      }
      Get.snackbar(
        'Favorite',
        '${product.name} ${wasFavorite ? AppString.removedSuccess : AppString.addedToFavorite}',
      );
    } catch (e) {
      debugPrint('toggleFavorite error: $e');
      Get.snackbar('Favorite', 'تعذر تحديث المفضلة');
    }
  }

  Future<void> removeFavorite(String productId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore.deleteDocument(
        collectionPath: FirestoreCollections.favorites(uid),
        documentId: productId,
      );
    } catch (e) {
      debugPrint('removeFavorite error: $e');
    }
  }

  @override
  void onClose() {
    _authSub?.cancel();
    _favSub?.cancel();
    super.onClose();
  }
}