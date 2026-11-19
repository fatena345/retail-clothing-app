import 'package:get/get.dart';
import 'package:geeta/view/home/home_section/home_controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }

}