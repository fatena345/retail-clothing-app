import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

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
            CircleAvatar(
              radius: 65,
              backgroundColor: const Color(0xFFA1E3C4),
              child: const Icon(Icons.check, size: 65, color: Color(0xFF2CB67D)),
            ),
            SizedBox(height: AppHeight.h50),
            CustomText(
              text: AppString.congratsPlacingOrder,
              fontSize: AppFontSize.s22,
              fontWeight: AppFontWeight.bold,
              align: TextAlign.center,
            ),
            SizedBox(height: AppHeight.h15),
            CustomText(
              text: AppString.congratsSubTitle,
              fontSize: AppFontSize.s13,
              color: AppColors.greyText,
              align: TextAlign.center,
            ),
            const Spacer(),
            CustomElevatedButton(
              width: double.infinity,
              color: AppColors.primary,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_shipping_outlined, color: AppColors.white),
                  SizedBox(width: AppWidth.w10),
                  CustomText(
                    text: AppString.trackOrder,
                    color: AppColors.white,
                    fontWeight: AppFontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.h15),
            CustomElevatedButton(
              width: double.infinity,
              color: AppColors.primary,
              onPressed: () {
                Get.offAllNamed(AppRoutes.home);
              },
              child: CustomText(
                text: AppString.continueShopping,
                color: AppColors.white,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            SizedBox(height: AppHeight.h20),
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