import 'package:get/get.dart';
import 'package:ui_test/view/auth/register/register_controllers/register_controller.dart';


class RegisterBinding extends Bindings{
  @override
  @override
  void dependencies() {
    Get.put(RegisterController());
  }

}