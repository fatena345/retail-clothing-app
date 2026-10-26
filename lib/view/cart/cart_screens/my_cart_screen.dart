import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:geeta/core/controllers/cart/cart_controller.dart';
import 'package:geeta/view/cart/cart_screens/widgets/cart_item_tile.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';

import '../../../widgets/checkout_bottom_sheet.dart';

class MyCartScreen extends GetView<CartController> {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: AppColors.blackText),
        ),
        title: CustomText(
          text: AppString.myCart,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        builder: (c) {
          if (c.isLoading) {
            return Center(
              child: SpinKitThreeBounce(
                color: AppColors.primary,
                size: DefaultValues.indicatorSize,
              ),
            );
          }

          if (c.cartItems.isEmpty) return const _EmptyCart();

          return Stack(
            children: [
              ListView.separated(
                padding: EdgeInsetsDirectional.only(
                  top: AppPaddingHeight.p15,
                  start: AppPaddingWidth.p20,
                  end: AppPaddingWidth.p20,
                  bottom: AppPaddingHeight.p110,
                ),
                itemCount: c.cartItems.length,
                separatorBuilder: (_, __) => SizedBox(height: AppHeight.h15),
                itemBuilder: (_, index) => CartItemTile(
                  item: c.cartItems[index],
                  controller: c,
                ),
              ),
              PositionedDirectional(
                bottom: AppPaddingHeight.p25,
                start: AppPaddingWidth.p20,
                end: AppPaddingWidth.p20,
                child: CustomElevatedButton(
                  width: double.infinity,
                  color: AppColors.primary,
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const CheckoutBottomSheet(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Icon(Icons.login, color: AppColors.white),
                      SizedBox(width: AppWidth.w10),
                      CustomText(
                        text: AppString.goToCheckout,
                        color: AppColors.white,
                        fontWeight: AppFontWeight.bold,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPaddingWidth.p8,
                          vertical: AppPaddingHeight.p4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.circular(AppRadius.r6),
                        ),
                        child: CustomText(
                          text: '\$${c.totalCost.toStringAsFixed(2)}',
                          color: AppColors.white,
                          fontSize: AppFontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: AppColors.greyText.withAlpha(120),
          ),
          SizedBox(height: AppHeight.h15),
          CustomText(
            text: AppString.noData,
            color: AppColors.greyText,
            fontSize: AppFontSize.s16,
          ),
        ],
      ),
    );
  }
}

