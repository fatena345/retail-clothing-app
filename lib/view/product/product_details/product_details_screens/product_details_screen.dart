import 'package:flutter/material.dart';
import 'package:geeta/view/product/product_details/product_details_screens/widgets/quantity_selector.dart';
import 'package:geeta/view/product/product_details/product_details_screens/widgets/size_selector.dart';
import 'package:geeta/view/product/product_details/product_details_screens/widgets/top_bar.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_icons.dart';
import 'package:geeta/core/constants/app_images.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/view/product/product_details/product_details_controllers/product_details_controller.dart';
import 'package:geeta/view/product/product_details/product_details_screens/widgets/rating_row.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:geeta/widgets/formatted_price.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;

    return Scaffold(
      backgroundColor: AppColors.productBackground,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(controller: controller),
            Expanded(
              flex: 3,
              child: Center(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Image.asset(AppImages.image),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppPaddingWidth.p25),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.r40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: AppString.geetaMens,
                      color: AppColors.blackText,
                      fontSize: AppFontSize.s12,
                      fontWeight: AppFontWeight.regular,
                    ),
                    SizedBox(height: AppHeight.h4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: product.name,
                            fontSize: AppFontSize.s24,
                            textOverflow: TextOverflow.ellipsis,
                            maxLignes: 3,
                          ),
                        ),
                        FormattedPrice(
                          price: product.price,
                          color: AppColors.blackText,
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeight.h3),
                    RatingRow(),
                    SizedBox(height: AppHeight.h15),
                    Row(
                      children: [
                        QuantitySelector(controller: controller),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: AppColors.lightBlue,
                          child: AppIcons.upload,
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeight.h15),
                    CustomText(
                      text: AppString.description,
                      fontSize: AppFontSize.s12,
                      fontWeight: AppFontWeight.bold,
                    ),
                    SizedBox(height: AppHeight.h4),
                    CustomText(
                      text: product.description.isNotEmpty
                          ? product.description
                          : AppString.noDescription,
                      fontSize: AppFontSize.s12,
                      color: AppColors.greyText,
                      maxLignes: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppHeight.h15),
                    CustomText(
                      text: AppString.selectSize,
                      fontSize: AppFontSize.s12,
                      fontWeight: AppFontWeight.bold,
                    ),
                    SizedBox(height: AppHeight.h8),
                    SizeSelector(controller: controller),
                    const Spacer(),
                    CustomElevatedButton(
                      width: double.infinity,
                      color: AppColors.primary,
                      onPressed: controller.addToCart,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppIcons.cartWhite,
                          SizedBox(width: AppWidth.w10),
                          CustomText(
                            text: AppString.addToCart,
                            color: AppColors.white,
                            fontWeight: AppFontWeight.bold,
                            fontSize: AppFontSize.s11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
