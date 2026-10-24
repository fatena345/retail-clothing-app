import 'package:get/get.dart';
import 'package:ui_test/core/class/status_class.dart';
import 'package:ui_test/core/constants/api_endpoints.dart';
import 'package:ui_test/core/services/crud.dart';

class LoginController extends GetxController {
  bool rememberMe = false;

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    update();
  }

  StatusClass status = StatusClass.initial;

  Future<bool> login({required String email, required String password}) async {
    status = StatusClass.loading;
    update();

    final result = await Crud.postData(
      url: ApiEndpoints.login,
      body: {
        "email": email,
        "password": password,
      },
      saveTokenAfterSuccess: true,
    );

    return result.fold(
          (left) {
        status = left;
        update();
        return false;
      },
          (right) {
        status = StatusClass.success;
        update();
        return true;
      },
    );
  }
}