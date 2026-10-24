import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/class/status_class.dart';
import 'package:ui_test/core/constants/api_endpoints.dart';
import 'package:ui_test/core/services/crud.dart';

class CreateProductController extends GetxController {
  StatusClass status = StatusClass.initial;

  Future<bool> createProduct({
    required String title,
    required num price,
    required String description,
    required int categoryId,
    required String image,
  }) async {
    status = StatusClass.loading;
    update();

    final result = await Crud.postData(
      url: ApiEndpoints.products,
      body: {
        "title": title,
        "price": price,
        "description": description,
        "categoryId": categoryId,
        "images": [image]
      },
    );



    debugPrint("result = $result");
    return result.fold(
          (left) {
        status = left;
        update();
        return false;
      },
          (right) {
        status = StatusClass.success;
        update();
        return true;
      },
    );
  }
}