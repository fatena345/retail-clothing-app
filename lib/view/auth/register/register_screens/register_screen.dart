import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/core/class/default_values.dart';
import 'package:geeta/core/constants/enum.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/view/auth/register/register_controllers/register_controller.dart';
import 'package:geeta/view/auth/widgets/auth_form.dart';
import 'package:geeta/view/auth/widgets/auth_header.dart';

class RegisterScreen extends StatelessWidget {

 const  RegisterScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (controller) {
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: controller.status.isLoading,
            progressIndicator: SpinKitThreeBounce(
  color: AppColors.primary,
  size: DefaultValues.indicatorSize,
),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(
                    isLogin: false,
                    title: AppString.registerTitle,
                    subTitle: AppString.registerSubTitle,
                    height: AppHeight.h352,
                    textButton: AppString.register,
                  ),
                  AuthForm(
  formKey: controller.formKey,
  isLogin: false,
  nameController: controller.name,
  emailController: controller.email,
  passwordController: controller.password,
  commericalNameController: controller.commercialName,        
  commericalAccountController: controller.commercialAccount,  
  storeLicensePath: controller.storeLicensePath.text,
  onPickFromGallery: () => controller.selectStoreLicense(ImageSource.gallery),
  onPickFromCamera: () => controller.selectStoreLicense(ImageSource.camera),
  pressedButton: () async {
    if (!controller.formKey.currentState!.validate()) return;

    final result = await controller.submit();

    switch (result) {
      case RegisterResult.success:
        Get.snackbar(AppString.success, AppString.registerSuccess);
        Get.offAllNamed(AppRoutes.home);
      case RegisterResult.savedOffline:
        Get.snackbar(AppString.noInternet, AppString.dataStoredLocally);
      case RegisterResult.failed:
        Get.snackbar(
          AppString.error,
          controller.status.message ?? AppString.signupFailed,
        );
    }
  },
),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}