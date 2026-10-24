import 'package:get/get.dart';
import 'package:ui_test/core/class/status_class.dart';
import 'package:ui_test/core/constants/api_endpoints.dart';
import 'package:ui_test/core/constants/app_keys.dart';
import 'package:ui_test/core/services/crud.dart';
import 'package:ui_test/core/services/storage_manager.dart';
import 'package:ui_test/view/profile/profile_models/profile_model.dart';

class ProfileController extends GetxController {
  ProfileModel? profile;
  StatusClass status = StatusClass.loading;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    status = StatusClass.loading;
    update();

    final storage = await StorageManager.getInstance();
    final token = await storage.getData(key: AppKeys.token);

    if (token == null || token.toString().isEmpty) {
      status = StatusClass.serverError(message: 'No auth token found');
      update();
      return;
    }

    final result = await Crud.getData(
      url: ApiEndpoints.profile,
      token: token.toString(),
    );

    result.fold(
          (left) {
        status = left;
        update();
      },
          (right) {
        if (right is Map<String, dynamic>) {
          profile = ProfileModel.fromJson(right);
          status = StatusClass.success;
        } else {
          status = StatusClass.noData;
        }
        update();
      },
    );
  }

  Future<void> logout() async {
    final storage = await StorageManager.getInstance();
    await storage.removeData(key: AppKeys.token);
  }
}