import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/auth/login/login_controllers/login_controlller.dart';
import 'package:ui_test/view/auth/widgets/auth_form.dart';
import 'package:ui_test/view/auth/widgets/auth_header.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: Get.find<LoginController>(),
      builder: (controller) {
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: controller.status.isLoading,
            progressIndicator: const CircularProgressIndicator(color: AppColors.primary),
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
                    isLogin: true,
                    passwordController: password,
                    emailController: email,
                    pressedButton: () async {
                      if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
                        Get.snackbar('Validation', 'Please fill all fields');
                        return;
                      }

                      final success = await controller.login(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );

                      if (success) {
                        Get.snackbar('Success', 'Login successful');
                        await Future.delayed(const Duration(milliseconds: 500));
                        Get.offAllNamed(AppRoutes.home);
                      } else {
                        Get.snackbar(
                          'Failed',
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