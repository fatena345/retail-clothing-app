import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_images.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: AppColors.blackText),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(AppImages.failedStatus),
            SizedBox(height: AppHeight.h40),
            CustomText(
              text: AppString.failedPlacedOrderTitle,
              fontSize: AppFontSize.s22,
              fontWeight: AppFontWeight.bold,
              align: TextAlign.center,
            ),
            SizedBox(height: AppHeight.h15),
            CustomText(
              text: AppString.failedPlacedOrderSubTitle,
              fontSize: AppFontSize.s13,
              color: AppColors.greyText,
              align: TextAlign.center,
            ),
            const Spacer(),
            CustomElevatedButton(
              width: double.infinity,
              color: AppColors.primary,
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                text: AppString.tryAgain,
                color: AppColors.white,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            SizedBox(height: AppHeight.h25),
            GestureDetector(
              onTap: () => Get.offAllNamed(AppRoutes.home),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back, size: 16),
                  SizedBox(width: AppWidth.w8),
                  CustomText(
                    text: AppString.backToHome,
                    fontWeight: AppFontWeight.bold,
                    fontSize: AppFontSize.s12,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.h30),
          ],
        ),
      ),
    );
  }
}