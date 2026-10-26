import 'package:flutter/material.dart';
import 'package:geeta/core/services/firebase/notifications_service.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:geeta/widgets/form/custom_input_field.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
        title: CustomText(
          text: AppString.creditDebitCard,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddingWidth.p25,
          vertical: AppPaddingHeight.p15,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppPaddingWidth.p25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B42F8), Color(0xFF8863FA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppRadius.r20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B42F8).withAlpha(80),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 12, backgroundColor: Colors.red.withAlpha(200)),
                        Transform.translate(
                          offset: const Offset(-8, 0),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.amber.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppHeight.h30),
                  CustomText(
                    text: '5757  4747  5757  4747',
                    color: AppColors.white,
                    fontSize: AppFontSize.s18,
                    fontWeight: AppFontWeight.bold,
                  ),
                  SizedBox(height: AppHeight.h25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'VARAT SINGH SHARMA',
                        color: AppColors.white,
                        fontSize: AppFontSize.s12,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      CustomText(
                        text: '07/21',
                        color: AppColors.white,
                        fontSize: AppFontSize.s12,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppHeight.h25),
            const Icon(Icons.camera_alt_outlined, color: AppColors.greyText, size: 36),
            SizedBox(height: AppHeight.h25),
            CustomInputField(
              hintText: 'Varat Singh Sharma',
              title: AppString.nameOnCard,
            ),
            SizedBox(height: AppHeight.h15),
            CustomInputField(
              hintText: '4747 4747 4747 4747',
              title: AppString.cardNumber,
              suffixIcon: const Icon(Icons.credit_card, color: Colors.orange),
            ),
            SizedBox(height: AppHeight.h15),
            Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    hintText: '07/21',
                    title: AppString.expiryDate,
                  ),
                ),
                SizedBox(width: AppWidth.w15),
                Expanded(
                  child: CustomInputField(
                    hintText: '474',
                    title: AppString.cvc,
                    suffixIcon: const Icon(Icons.credit_card_outlined, color: AppColors.greyText),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppHeight.h40),
            CustomElevatedButton(
              width: double.infinity,
              color: AppColors.primary,
              onPressed: () async {
  await Get.find<NotificationsService>().showLocal(
    title: AppString.paymentSuccessTitle,
    body: AppString.paymentSuccessBody,
    data: {'type': 'order'},
  );
  Get.toNamed(AppRoutes.success);
},
              child: CustomText(
                text: AppString.useThisCard,
                color: AppColors.white,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}