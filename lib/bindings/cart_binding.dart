import 'package:geeta/view/cart/cart_controller/cart_controller.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }

}