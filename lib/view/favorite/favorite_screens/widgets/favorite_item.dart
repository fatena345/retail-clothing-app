import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_images.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/model/product/product_model.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:get/get.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key,required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
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
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_,_,_) => Image.asset(AppImages.image),
              ),
            ),
          ),
          SizedBox(width: AppWidth.w15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: product.name,
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
                text: '\$${product.price.toStringAsFixed(2)} USD',
                fontSize: AppFontSize.s14,
                fontWeight: AppFontWeight.bold,
              ),
              SizedBox(height: AppHeight.h15),
              GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.productDetails,
                  arguments: product,
                ),
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
  }
}

