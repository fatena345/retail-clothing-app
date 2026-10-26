import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/controllers/favorite/favorite_controller.dart';
import 'package:geeta/view/product/product_details/product_details_controllers/product_details_controller.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
   const TopBar({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p20,
        vertical: AppPaddingHeight.p10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back, color: AppColors.blackText),
          ),
          GetBuilder<FavoriteController>(
  builder: (fav) {
    final isFav = fav.isFavorite(controller.product.id);
    return CircleAvatar(
      backgroundColor: AppColors.white,
      radius: AppRadius.r22,
      child: IconButton(
        onPressed: () => fav.toggleFavorite(controller.product),
        icon: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? AppColors.red : AppColors.blackText,
        ),
      ),
    );
  },
)
        ],
      ),
    );
  }
}
