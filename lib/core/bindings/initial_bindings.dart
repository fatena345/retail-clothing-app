import 'package:get/get.dart';
import 'package:ui_test/core/services/crud.dart';
import 'package:ui_test/core/services/storage_manager.dart';
import 'package:ui_test/view/cart/cart_controllers/cart_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(StorageManager.getInstance());
    Get.put(CartController(), permanent: true);
  }
}