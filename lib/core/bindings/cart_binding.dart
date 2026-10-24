import 'package:get/get.dart';
import 'package:ui_test/view/cart/cart_controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}