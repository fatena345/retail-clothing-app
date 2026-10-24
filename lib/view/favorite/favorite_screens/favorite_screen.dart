import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_images.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';

import '../../../core/controllers/favorite/favorite_controller.dart';
import '../../../widgets/checkout_bottom_sheet.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
          text: AppString.favorite,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<FavoriteController>(
        init: Get.find<FavoriteController>(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (controller.favoriteList.isEmpty) {
            return Center(
              child: CustomText(
                text: AppString.noData,
                color: AppColors.greyText,
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
                  bottom: AppPaddingHeight.p100,
                ),
                itemCount: controller.favoriteList.length,
                separatorBuilder: (_, __) => SizedBox(height: AppHeight.h15),
                itemBuilder: (context, index) {
                  final product = controller.favoriteList[index];
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
                              product.images.first,
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
                              CustomText(
                                text: product.title,
                                color: AppColors.primary,
                                fontSize: AppFontSize.s15,
                                fontWeight: AppFontWeight.bold,
                                maxLignes: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: AppHeight.h4),
                              CustomText(
                                text: AppString.geetaCollection,
                                color: AppColors.greyText,
                                fontSize: AppFontSize.s11,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: '\$${product.price}.00 USD',
                              fontSize: AppFontSize.s14,
                              fontWeight: AppFontWeight.bold,
                            ),
                            SizedBox(height: AppHeight.h15),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.productDetails, arguments: product);
                              },
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: AppColors.blackText,
                              ),
                            ),
                          ],
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
                      const Icon(Icons.shopping_bag_outlined, color: AppColors.white),
                      SizedBox(width: AppWidth.w10),
                      CustomText(
                        text: AppString.addAllToCart,
                        color: AppColors.white,
                        fontWeight: AppFontWeight.bold,
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