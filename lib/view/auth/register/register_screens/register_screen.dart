import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/view/auth/register/register_controllers/register_controller.dart';
import 'package:geeta/view/auth/widgets/auth_form.dart';
import 'package:geeta/view/auth/widgets/auth_header.dart';

class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController name = TextEditingController();


  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: Get.find<RegisterController>(),
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
                    isLogin: false,
                    passwordController: password,
                    emailController: email,
                    nameController: name,
                    pressedButton: () async {
                      if (name.text.trim().isEmpty ||
                          email.text.trim().isEmpty ||
                          password.text.trim().isEmpty) {
                        Get.snackbar(AppString.validation, AppString.validationHint);
                        return;
                      }

                      final success = await controller.register(
                        name: name.text.trim(),
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );

                      if (success) {
                        Get.snackbar(AppString.success, AppString.registerSuccess);
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