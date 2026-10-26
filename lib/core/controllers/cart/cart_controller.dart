import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:get/get.dart';

import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';
import 'package:geeta/model/product/product_model.dart';

import '../../../model/cart/cart_item_model.dart';

class CartController extends GetxController {
  final FirebaseAuthService _auth = Get.find();
  final FirestoreService _firestore = Get.find();

  StreamSubscription<User?>? _authSub;
  StreamSubscription<List<Map<String, dynamic>>>? _cartSub;

  List<CartItemModel> cartItems = [];
  bool isLoading = false;

  double get totalCost => cartItems.fold(0, (sum, item) => sum + item.total);
  int get itemsCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  @override
  void onInit() {
    super.onInit();
    _authSub = _auth.authStateChanges.listen(_onAuthChanged);
  }

  // ================== Session ==================
  void _onAuthChanged(User? user) {
    _cartSub?.cancel();
    _cartSub = null;

    if (user == null) {
      cartItems = [];
      isLoading = false;
      update();
      return;
    }

    isLoading = true;
    update();

    _cartSub = _firestore
        .watchCollection(
          collectionPath: FirestoreCollections.cart(user.uid),
          query: (q) => q.orderBy('addedAt'),
        )
        .listen(
      (data) {
        cartItems = data.map(CartItemModel.fromMap).toList();
        isLoading = false;
        update();
      },
      onError: (e) {
        debugPrint('cart stream error: $e');
        isLoading = false;
        update();
      },
    );
  }

  String? get _uid => _auth.currentUser?.uid;

  // ================== Actions ==================

  /// إضافة منتج، أو زيادة كميته لو موجود بنفس المقاس
  Future<bool> addToCart({
    required ProductModel product,
    int quantity = 1,
    String size = 'S',
  }) async {
    final uid = _uid;
    if (uid == null) {
      Get.snackbar('Cart', 'سجّل دخولك أولاً');
      return false;
    }

    try {
      await _firestore.setDocument(
        collectionPath: FirestoreCollections.cart(uid),
        documentId: CartItemModel.buildId(product.id, size),
        data: {
          'productId': product.id,
          'product': product.toUpdateMap(),
          'size': size,
          'quantity': FieldValue.increment(quantity),
          'addedAt': FieldValue.serverTimestamp(),
        },
        merge: true,
      );
      return true;
    } catch (e) {
      debugPrint('addToCart error: $e');
      Get.snackbar('Cart', 'تعذر إضافة المنتج للسلة');
      return false;
    }
  }

  Future<void> incrementQuantity(CartItemModel item) =>
      _changeQuantity(item, 1);

  Future<void> decrementQuantity(CartItemModel item) async {
    if (item.quantity <= 1) {
      await removeFromCart(item);
    } else {
      await _changeQuantity(item, -1);
    }
  }

  Future<void> removeFromCart(CartItemModel item) async {
    final uid = _uid;
    if (uid == null) return;

    try {
      await _firestore.deleteDocument(
        collectionPath: FirestoreCollections.cart(uid),
        documentId: item.id,
      );
    } catch (e) {
      debugPrint('removeFromCart error: $e');
    }
  }

  /// إفراغ السلة بعد إتمام الطلب (Batch واحد بدل حذف عنصر عنصر)
  Future<void> clearCart() async {
    final uid = _uid;
    if (uid == null || cartItems.isEmpty) return;

    try {
      await _firestore.deleteDocuments(
        collectionPath: FirestoreCollections.cart(uid),
        documentIds: cartItems.map((e) => e.id).toList(),
      );
    } catch (e) {
      debugPrint('clearCart error: $e');
    }
  }

  Future<void> _changeQuantity(CartItemModel item, int delta) async {
    final uid = _uid;
    if (uid == null) return;

    try {
      await _firestore.updateDocument(
        collectionPath: FirestoreCollections.cart(uid),
        documentId: item.id,
        data: {'quantity': FieldValue.increment(delta)},
      );
    } catch (e) {
      debugPrint('changeQuantity error: $e');
    }
  }

  @override
  void onClose() {
    _authSub?.cancel();
    _cartSub?.cancel();
    super.onClose();
  }
}