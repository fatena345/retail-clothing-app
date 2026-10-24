import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/splash/splash_screens/widgets/dot_indicator.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

import '../../../core/constants/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:AssetImage(AppImages.splashBackground) ,
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          spacing: AppHeight.h50,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: AppString.appTitle,
              color: AppColors.white,
              fontSize: AppFontSize.s104,),
            CustomElevatedButton(
                onPressed: (){
                  Get.toNamed(AppRoutes.welcome);
                },

                isSmallButton: true,
                borderColor: AppColors.white,
                child: CustomText(
                  text: AppString.shopNow,
                  color: AppColors.white,
                ),
            ),
            SafeArea(child: DotIndicator()),

          ],
        ),
      ),
    );
  }
}
