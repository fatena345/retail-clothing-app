import 'package:geeta/view/product/create_product/create_product_controller/create_product_controller.dart';
import 'package:get/get.dart';

class CreateProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateProductController());
  }
}