import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_icons.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/constants/default_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

import '../../../widgets/form/custom_input_field.dart';
import '../login/login_controllers/login_controlller.dart';

class AuthForm extends StatelessWidget {
   final bool isLogin;
   //final Key formKey;
   final VoidCallback pressedButton;
   final TextEditingController emailController;
   final TextEditingController passwordController;
   final TextEditingController? nameController;
    final bool? rememberMe;
  const AuthForm({super.key,
    //required this.formKey,
    required this.isLogin,
    required this.passwordController,
    required this.emailController,
    this.nameController,
    this.rememberMe,
    required this.pressedButton
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      //key: formKey,
      child: Padding(
        padding: DefaultValues.authFormPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isLogin)
            CustomInputField(
              controller: emailController,
              hintText: AppString.hints['email']!,
              title: AppString.emailAddress,
              prefixIcon: AppIcons.email,
            ),
            if(!isLogin)
                CustomInputField(
                  controller: nameController,
                  hintText: AppString.hints['name']!,
                  title: AppString.yourName,
                  prefixIcon: AppIcons.person,
                ),
            if(!isLogin)
              SizedBox(height: DefaultValues.spaceBetwwenFields,),
            if(!isLogin)
                CustomInputField(
                  controller: emailController,
                  hintText: AppString.hints['email']!,
                  title: AppString.emailAddress,
                  prefixIcon: AppIcons.email,
                ),
            SizedBox(height: DefaultValues.spaceBetwwenFields,),
            CustomInputField(
              controller: passwordController,
              hintText: AppString.hints['password']!,
              title: AppString.password,
              prefixIcon: AppIcons.password,
            ),
            if(isLogin)
              SizedBox(height: AppHeight.h16),
           if(isLogin)
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GetBuilder<LoginController>(
                   init: Get.find<LoginController>(),
                   builder: (controller) {
                     return Row(
                       spacing: AppWidth.w5,
                       children: [
                         Checkbox(
                           value: controller.rememberMe,
                           onChanged: controller.toggleRememberMe,
                         ),
CustomText(text: AppString.rememberMe, fontSize: AppFontSize.s12, fontWeight: AppFontWeight.regular,)
                       ],
                     );
                   },
                 ),
                 CustomText(text: AppString.forgotPassword, color: AppColors.primary,fontWeight: AppFontWeight.semiBold,)
               ],
             ),
            SizedBox(height: AppHeight.h13),
            CustomElevatedButton(onPressed: pressedButton,
               child: CustomText(
                 text:
                 isLogin
                     ?
                 AppString.login
                     :
                 AppString.register,
                 fontSize: AppFontSize.s11,
                 align: TextAlign.center,
                 color: AppColors.white,
               ),
            
            ),
            SizedBox(height: AppHeight.h5),
            if(isLogin)
              Row(
                spacing:AppWidth.w3 ,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: AppString.notRegistered, color: AppColors.greyText,
                  fontSize: AppFontSize.s12, fontWeight: AppFontWeight.regular,
                  ),
                  TextButton(onPressed: ()
                      {
                        Get.toNamed(AppRoutes.register);
                      }, child:
                  CustomText(text: AppString.createAccount, color: AppColors.primary,
                    fontSize: AppFontSize.s12, fontWeight: AppFontWeight.regular,
                  ),
                  ),
                ],
              ),
            if(!isLogin)
              CustomText
                (text: AppString.agreeToReceiveEmail,
                align:TextAlign.center,
                color: AppColors.greyText,
                fontSize: AppFontSize.s12, fontWeight: AppFontWeight.regular,

              ),
          ],
        ),
      ),

    );
  }
}
