import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p25),
      decoration: BoxDecoration(
        color: AppColors.productBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r30),
          topRight: Radius.circular(AppRadius.r30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppString.checkout,
                fontSize: AppFontSize.s20,
                fontWeight: AppFontWeight.bold,
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: AppColors.greyText),
              ),
            ],
          ),
          const Divider(),
          _buildRow(
            title: AppString.delivery,
            value: AppString.selectMethod,
            onTap: () {},
          ),
          const Divider(),
          _buildRow(
            title: AppString.payment,
            isCard: true,
            onTap: () {
              Get.back();
              Get.toNamed(AppRoutes.payment);
            },
          ),
          const Divider(),
          _buildRow(
            title: AppString.promoCode,
            value: AppString.pickDiscount,
            onTap: () {},
          ),
          const Divider(),
          _buildRow(
            title: AppString.totalCost,
            value: '\$135.96',
            isTotal: true,
            onTap: () {},
          ),
          const Divider(),
          SizedBox(height: AppHeight.h15),
          Center(
            child: CustomText(
              text: AppString.agreeTermsPlacingOrder,
              color: AppColors.greyText,
              fontSize: AppFontSize.s11,
              align: TextAlign.center,
            ),
          ),
          SizedBox(height: AppHeight.h20),
          CustomElevatedButton(
            width: double.infinity,
            color: AppColors.primary,
            onPressed: () {
              Get.back();
              Get.toNamed(AppRoutes.success);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_shipping_outlined, color: AppColors.white),
                SizedBox(width: AppWidth.w10),
                CustomText(
                  text: AppString.placeOrder,
                  color: AppColors.white,
                  fontWeight: AppFontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(height: AppHeight.h10),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String title,
    String? value,
    bool isCard = false,
    bool isTotal = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: AppFontSize.s15,
              fontWeight: AppFontWeight.bold,
            ),
            Row(
              children: [
                if (isCard)
                  Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.credit_card, size: 16, color: Colors.white),
                  )
                else
                  CustomText(
                    text: value ?? '',
                    color: isTotal ? AppColors.primary : AppColors.primary,
                    fontWeight: AppFontWeight.bold,
                    fontSize: isTotal ? AppFontSize.s16 : AppFontSize.s14,
                  ),
                SizedBox(width: AppWidth.w8),
                const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}