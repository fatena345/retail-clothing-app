import 'package:flutter/foundation.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:get/get.dart';
import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';
import 'package:geeta/model/product/product_model.dart';

class HomeController extends GetxController {
  final FirestoreService _firestore = Get.find();

  List<ProductModel> products = [];
  StatusClass status = StatusClass.loading;
  bool isDeleting = false;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

 
  Future<void> getProducts() async {
    status = StatusClass.loading;
    update();

    try {
      final data = await _firestore.getCollectionData(
        collectionPath: FirestoreCollections.products,
        query: (q) => q.orderBy('createdAt', descending: true),
      );

      products = data.map(ProductModel.fromMap).toList();
      status = products.isEmpty ? StatusClass.noData : StatusClass.success;
    } catch (e) {
      debugPrint('getProducts error: $e');
      status = StatusClass.anotherError(message: 'تعذر تحميل المنتجات');
    }

    update();
  }




  Future<bool> updateProduct(ProductModel product) async {
    try {
      await _firestore.updateDocument(
        collectionPath: FirestoreCollections.products,
        documentId: product.id,
        data: product.toUpdateMap(),
      );

      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
        update();
      }
      return true;
    } catch (e) {
      debugPrint('updateProduct error: $e');
      return false;
    }
  }



  Future<bool> deleteProduct(String productId) async {
    if (isDeleting) return false;
    isDeleting = true;
    update();

    var success = false;
    try {
      await _firestore.deleteDocument(
        collectionPath: FirestoreCollections.products,
        documentId: productId,
      );
      products.removeWhere((p) => p.id == productId);
      if (products.isEmpty) status = StatusClass.noData;
      success = true;
    } catch (e) {
      debugPrint('deleteProduct error: $e');
    }

    isDeleting = false;
    update();
    return success;
  }
}