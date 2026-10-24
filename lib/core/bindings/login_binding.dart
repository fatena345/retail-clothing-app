import 'package:get/get.dart';


import '../../view/auth/login/login_controllers/login_controlller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
  }

}