import 'package:get/get.dart';
import 'package:ui_test/view/product/create_product/create_product_controllers/create_product_controller.dart';

class CreateProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateProductController());
  }
}