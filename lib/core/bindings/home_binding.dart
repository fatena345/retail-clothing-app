import 'package:get/get.dart';
import 'package:ui_test/view/home/home_controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }

}