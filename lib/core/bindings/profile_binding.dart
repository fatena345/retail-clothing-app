import 'package:get/get.dart';
import 'package:ui_test/view/profile/profile_controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}