import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/core/class/default_values.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/view/auth/login/login_controllers/login_controlller.dart';
import 'package:geeta/view/auth/widgets/auth_form.dart';
import 'package:geeta/view/auth/widgets/auth_header.dart';

class LoginScreen extends StatelessWidget {

 const  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
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
                    isLogin: true,
                    title: AppString.welcomeBack,
                    subTitle: AppString.loginParagraph,
                    height: AppHeight.h434,
                    textButton: AppString.login,
                  ),
                  AuthForm(
                    formKey: controller.formKey,
                    isLogin: true,
                    passwordController: controller.password,
                    emailController: controller.email,
                    pressedButton: () async {
                      if (controller.email.text.trim().isEmpty || controller.password.text.trim().isEmpty) {
                        Get.snackbar(AppString.validation, AppString.validationHint);
                        return;
                      }

                      final success = await controller.login();

                      if (success) {
                        Get.snackbar(AppString.success, AppString.loginSuccessful);
                        await Future.delayed(const Duration(milliseconds: 500));
                        Get.offAllNamed(AppRoutes.home);
                      } else {
                        Get.snackbar(
                          AppString.failed,
                          controller.status.message ??
                              (controller.status.isNoInternet
                                  ? AppString.noInternet
                                  : AppString.wrong),
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