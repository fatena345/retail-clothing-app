import 'package:geeta/view/favorite/favorite_controllers/favorite_controller.dart';
import 'package:get/get.dart';

class FavoriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }

}