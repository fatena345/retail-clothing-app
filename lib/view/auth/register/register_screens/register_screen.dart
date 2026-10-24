import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/auth/register/register_controllers/register_controller.dart';
import 'package:ui_test/view/auth/widgets/auth_form.dart';
import 'package:ui_test/view/auth/widgets/auth_header.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: Get.find<RegisterController>(),
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
                    isLogin: false,
                    title: AppString.registerTitle,
                    subTitle: AppString.registerSubTitle,
                    height: AppHeight.h352,
                    textButton: AppString.register,
                  ),
                  AuthForm(
                    isLogin: false,
                    passwordController: password,
                    emailController: email,
                    nameController: name,
                    pressedButton: () async {
                      if (name.text.trim().isEmpty ||
                          email.text.trim().isEmpty ||
                          password.text.trim().isEmpty) {
                        Get.snackbar('Validation', 'Please fill all fields');
                        return;
                      }

                      final success = await controller.register(
                        name: name.text.trim(),
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );

                      if (success) {
                        Get.snackbar('Success', 'Registered successfully');
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