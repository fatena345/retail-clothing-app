import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geeta/core/helpful_functions/validators/is_valid_email.dart';
import 'package:geeta/core/helpful_functions/validators/is_valid_password.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_icons.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/class/default_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';

import '../../../widgets/form/custom_input_field.dart';
import '../login/login_controllers/login_controlller.dart';

class AuthForm extends StatelessWidget {
   final bool isLogin;
   final Key formKey;
   final VoidCallback pressedButton;
   final TextEditingController emailController;
   final TextEditingController passwordController;
   final TextEditingController? nameController;
   final TextEditingController? commericalNameController;
   final TextEditingController? commericalAccountController;
   final String? storeLicensePath;
final VoidCallback? onPickFromGallery;
final VoidCallback? onPickFromCamera;
   
    final bool? rememberMe;
  const AuthForm({super.key,
    required this.formKey,
    required this.isLogin,
    required this.passwordController,
    required this.emailController,
    this.nameController,
    this.rememberMe,
    required this.pressedButton,
    this.commericalNameController,
     this.commericalAccountController,
    this.storeLicensePath,
this.onPickFromGallery,
this.onPickFromCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                  validator: 
                      (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.emailRequired;
                    }
                    if (!isValidEmail(value)) {
                      return AppString.invalidEmail;
                    }
                    return null;
                  },
                ),
            SizedBox(height: DefaultValues.spaceBetwwenFields,),
            CustomInputField(
              controller: passwordController,
              hintText: AppString.hints['password']!,
              title: AppString.password,
              prefixIcon: AppIcons.password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppString.passwordRequired;
                }
                if (!isValidPassword(value)) {
                  return AppString.invalidPassword;
                }
                return null;
              },
            ),
            if(!isLogin)
              SizedBox(height: DefaultValues.spaceBetwwenFields,),
            if(!isLogin)
                CustomInputField(
                  controller: commericalNameController,
                  hintText: AppString.hints['commericalNmae']!,
                  title: AppString.commericalName,
                  prefixIcon: AppIcons.commericalName,
                ),
                if(!isLogin)
              SizedBox(height: DefaultValues.spaceBetwwenFields,),
            if(!isLogin)
                CustomInputField(
                  controller: commericalAccountController,
                  hintText: AppString.hints['commericalAccount']!,
                  title: AppString.commericalAccount,
                  prefixIcon: AppIcons.commericalAccount,
                ),

if(!isLogin)
              SizedBox(height: DefaultValues.spaceBetwwenFields,),
            if (!isLogin)
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        text: AppString.storeLicense,
        fontSize: AppFontSize.s12,
      ),

       SizedBox(height: AppHeight.h10),

      if (storeLicensePath != null &&
          storeLicensePath!.isNotEmpty)
        Image.file(
          File(storeLicensePath!),
          height: AppHeight.h150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

      Row(
        children: [
          IconButton(
            onPressed: onPickFromGallery,
            icon: AppIcons.gallery,
          ),
          IconButton(
            onPressed: onPickFromCamera,
            icon: AppIcons.camera,
          ),
        ],
      ),
    ],
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
