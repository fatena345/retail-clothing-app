import 'package:get/get.dart';
import '../controllers/favorite/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController());
  }
}