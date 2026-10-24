import 'package:get/get.dart';
import 'package:ui_test/core/class/status_class.dart';
import 'package:ui_test/core/constants/api_endpoints.dart';
import 'package:ui_test/core/services/crud.dart';

class RegisterController extends GetxController {
  StatusClass status = StatusClass.initial;

  Future<bool> register({
    required String email,
    required String password,
    required String name,
  }) async {
    status = StatusClass.loading;
    update();

    final result = await Crud.postData(
      url: ApiEndpoints.users,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480"
      },
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