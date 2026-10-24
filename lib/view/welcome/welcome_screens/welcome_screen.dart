import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:AssetImage(AppImages.welcomeBackground) ,
              fit: BoxFit.cover
          ),
        ),
       child: Column(
         //mainAxisSize: MainAxisSize.min,
         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
            SizedBox(height: AppHeight.h117,),
           CustomText(text: AppString.appTitle, fontSize: AppFontSize.s44,),
           SizedBox(height:AppHeight.h130,),
           CustomText(text: AppString.welcomeTitle, fontSize: AppFontSize.s24, textOverflow: TextOverflow.visible, align: TextAlign.center,),
           SizedBox(height:AppHeight.h32,),
           CustomText(text: AppString.welcomeSubTitle, fontSize: AppFontSize.s14, textOverflow: TextOverflow.visible, align: TextAlign.center,),
           SizedBox(height:AppHeight.h49,),
           CustomElevatedButton(
             isSmallButton: true,
             borderColor: AppColors.blackText,
             onPressed: (){
                 Get.toNamed(AppRoutes.login);
               },
             child: CustomText(text: AppString.login, fontSize: AppFontSize.s11,),
           ),
           SizedBox(height:AppHeight.h25,),
           Row(
             spacing: AppWidth.w8,
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                 width: AppWidth.w21,
                 height:AppHeight.h1,
                 color: AppColors.greyText,
               ),
               CustomText(text: AppString.or, fontWeight: AppFontWeight.bold,),
               Container(
                 width: AppWidth.w21,
                 height:AppHeight.h1,
                 color: AppColors.greyText,
               ),
             ],
           ),
           SizedBox(height:AppHeight.h25,),
           CustomElevatedButton(
             isSmallButton: true,
             color: AppColors.primary,
             borderColor: AppColors.blackText,
             onPressed: (){
               Get.toNamed(AppRoutes.register);
             },
             child: CustomText(text: AppString.register,color: AppColors.white, fontSize: AppFontSize.s11,),
           ),
         ],
       ),
      ),
    );
  }
}
