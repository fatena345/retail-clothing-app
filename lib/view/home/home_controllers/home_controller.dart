import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/class/status_class.dart';
import 'package:ui_test/core/constants/api_endpoints.dart';
import 'package:ui_test/core/services/crud.dart';
import 'package:ui_test/model/product/product_model.dart';

class HomeController extends GetxController {
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

    final result = await Crud.getData(url: ApiEndpoints.products);

    result.fold(
          (left) {
        status = left;
        update();
      },
          (right) {
        if (right is List) {
          products = right.map((item) => ProductModel.fromJson(item)).toList();
          status = products.isEmpty ? StatusClass.noData : StatusClass.success;
        } else {
          status = StatusClass.noData;
        }
        update();
      },
    );
  }

  Future<bool> deleteProduct(int productId) async {
    isDeleting = true;
    update();

    final result = await Crud.deleteData(
      url: '${ApiEndpoints.products}$productId',
    );

    return result.fold(
          (left) {
        isDeleting = false;
        update();
        return false;
      },
          (right) {
        products.removeWhere((item) => item.id == productId);
        isDeleting = false;
        update();
        return true;
      },
    );
  }

}