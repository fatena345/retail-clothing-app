import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeta/core/constants/firestore_collections.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';
import 'package:geeta/model/product/product_model.dart';
import 'package:geeta/view/home/home_controllers/home_controller.dart';

class CreateProductController extends GetxController {
  final FirestoreService _firestore = Get.find();

  // الـ controllers بتنملك وبتنتخلص هون
  final titleCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final catIdCtrl = TextEditingController(text: '1');
  final imgCtrl = TextEditingController();

  bool isSaving = false;

  /// بترجع رسالة الخطأ لو في مشكلة بالمدخلات، أو null لو كله تمام
  String? _validate() {
    if (titleCtrl.text.trim().isEmpty ||
        descCtrl.text.trim().isEmpty ||
        imgCtrl.text.trim().isEmpty) {
      return AppString.validationHint;
    }
    final price = double.tryParse(priceCtrl.text.trim());
    if (price == null || price < 0) return AppString.inValidPrice;
    if (int.tryParse(catIdCtrl.text.trim()) == null) {
      return AppString.inValidCategoryId;
    }
    return null;
  }

  ProductModel _buildProduct() => ProductModel(
        name: titleCtrl.text.trim(),
        price: double.parse(priceCtrl.text.trim()),
        description: descCtrl.text.trim(),
        categoryId: int.parse(catIdCtrl.text.trim()),
        imageUrl: imgCtrl.text.trim(),
      );

  
  Future<void> submit() async {
    if (isSaving) return;

    final error = _validate();
    if (error != null) {
      Get.snackbar(AppString.alert, error);
      return;
    }

    isSaving = true;
    update();

    try {
      await _firestore.addDocument(
        collectionPath: FirestoreCollections.products,
        data: _buildProduct().toCreateMap(),
      );

      
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().getProducts();
      }

      Get.back();
      Get.snackbar(AppString.done, AppString.productCreatedSuccess);
    } on FirebaseException catch (e) {
      debugPrint('create product error: ${e.code}');
      Get.snackbar(
        AppString.failed,
        e.code == 'permission-denied'
            ? AppString.permissionNotExist
            : AppString.failedCreateProduct,
      );
    } catch (e) {
      debugPrint('create product error: $e');
      Get.snackbar(AppString.failed, AppString.failedCreateProduct);
    } finally {
      isSaving = false;
      update();
    }
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    priceCtrl.dispose();
    descCtrl.dispose();
    catIdCtrl.dispose();
    imgCtrl.dispose();
    super.onClose();
  }
}