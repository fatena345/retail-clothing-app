import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_images.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/view/cart/cart_controllers/cart_controller.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

import '../../../widgets/checkout_bottom_sheet.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

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
          text: AppString.myCart,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        init: Get.find<CartController>(),
        builder: (controller) {
          if (controller.cartItems.isEmpty) {
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

          return Stack(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(
                  top: AppPaddingHeight.p15,
                  left: AppPaddingWidth.p20,
                  right: AppPaddingWidth.p20,
                  bottom: AppPaddingHeight.p110,
                ),
                itemCount: controller.cartItems.length,
                separatorBuilder: (_, __) => SizedBox(height: AppHeight.h15),
                itemBuilder: (context, index) {
                  final cartItem = controller.cartItems[index];
                  final product = cartItem.product;

                  return Container(
                    padding: EdgeInsets.all(AppPaddingWidth.p15),
                    decoration: BoxDecoration(
                      color: AppColors.productBackground,
                      borderRadius: BorderRadius.circular(AppRadius.r16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                          child: Container(
                            width: AppWidth.w80,
                            height: AppHeight.h80,
                            color: AppColors.white,
                            child: Image.network(
                              product.images.isNotEmpty
                                  ? product.images.first
                                  : '',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(AppImages.image),
                            ),
                          ),
                        ),
                        SizedBox(width: AppWidth.w15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text: product.title,
                                      color: AppColors.primary,
                                      fontSize: AppFontSize.s15,
                                      fontWeight: AppFontWeight.bold,
                                      maxLignes: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.removeFromCart(index);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: AppColors.greyText,
                                    ),
                                  ),
                                ],
                              ),
                              CustomText(
                                text: '${AppString.geetaCollection} • Size: ${cartItem.size}',
                                color: AppColors.greyText,
                                fontSize: AppFontSize.s11,
                              ),
                              SizedBox(height: AppHeight.h10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: '\$${product.price}.00 USD',
                                    fontSize: AppFontSize.s14,
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppPaddingWidth.p6,
                                      vertical: AppPaddingHeight.p2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(AppRadius.r6),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => controller.decrementQuantity(index),
                                          child: const Icon(Icons.remove, size: 16),
                                        ),
                                        SizedBox(width: AppWidth.w10),
                                        CustomText(
                                          text: '${cartItem.quantity}',
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                        SizedBox(width: AppWidth.w10),
                                        GestureDetector(
                                          onTap: () => controller.incrementQuantity(index),
                                          child: const Icon(Icons.add, size: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: AppPaddingHeight.p25,
                left: AppPaddingWidth.p20,
                right: AppPaddingWidth.p20,
                child: CustomElevatedButton(
                  width: double.infinity,
                  color: AppColors.primary,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const CheckoutBottomSheet(),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.login, color: AppColors.white),
                          SizedBox(width: AppWidth.w10),
                          CustomText(
                            text: AppString.goToCheckout,
                            color: AppColors.white,
                            fontWeight: AppFontWeight.bold,
                          ),
                        ],
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
                          text: '\$${controller.totalCost.toStringAsFixed(2)}',
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