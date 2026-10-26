import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:geeta/core/controllers/favorite/favorite_controller.dart';
import 'package:geeta/model/product/product_model.dart';
import 'package:geeta/view/favorite/favorite_screens/widgets/favorite_item.dart';
import 'package:geeta/widgets/checkout_bottom_sheet.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:get/get.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

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
          text: AppString.favorite,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<FavoriteController>(
        builder: (c) {
          if (c.isLoading) {
            return Center(
              child: SpinKitThreeBounce(
                color: AppColors.primary,
                size: DefaultValues.indicatorSize,
              ),
            );
          }

          if (c.favoriteList.isEmpty) {
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
                padding: EdgeInsetsDirectional.only(
                  top: AppPaddingHeight.p15,
                  start: AppPaddingWidth.p20,
                  end: AppPaddingWidth.p20,
                  bottom: AppPaddingHeight.p100,
                ),
                itemCount: c.favoriteList.length,
                separatorBuilder: (_, __) => SizedBox(height: AppHeight.h15),
                itemBuilder: (_, index) =>
                    FavoriteItem(product: c.favoriteList[index]),
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
                      const Icon(Icons.shopping_bag_outlined,
                          color: AppColors.white),
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

