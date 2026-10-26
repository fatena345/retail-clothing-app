import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_images.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/model/product/product_model.dart';
import 'package:geeta/view/home/home_controllers/home_controller.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:geeta/widgets/formatted_price.dart';

import '../core/controllers/favorite/favorite_controller.dart';

class ProductGridCard extends StatelessWidget {
  final ProductModel product;

  const ProductGridCard({super.key, required this.product});

  void _showDeleteDialog(BuildContext context) {
    Get.defaultDialog(
      title: AppString.deleteProduce,
      middleText: AppString.deleteMessage,
      textConfirm: AppString.delete,
      textCancel: AppString.cancel,
      confirmTextColor: AppColors.white,
      buttonColor: AppColors.red,
      onConfirm: () async {
        Get.back();
        final homeCtrl = Get.find<HomeController>();
        final res = await homeCtrl.deleteProduct(product.id);
        if (res) {
          Get.snackbar('Success', AppString.productDeletedSuccess);
        } else {
          Get.snackbar('Failed', AppString.failedDeleteProduct);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: product);
      },
      onLongPress: () => _showDeleteDialog(context),
      child: Column(
        spacing: AppHeight.h10,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r30),
                child: Container(
                  color: AppColors.lightBlue,
                  height: AppHeight.h170,
                  width: double.infinity,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImages.image,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: AppHeight.h15,
                right: AppWidth.w15,
                child: GetBuilder<FavoriteController>(
                  builder: (_) {
                    final isFav = favCtrl.isFavorite(product.id);
                    return GestureDetector(
                      onTap: () {
                        favCtrl.toggleFavorite(product);
                      },
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? AppColors.red : AppColors.blackText,
                        size: AppSize.s24,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomText(
                text: product.name,
                align: TextAlign.center,
                maxLignes: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
              FormattedPrice(price: product.price),
            ],
          ),
        ],
      ),
    );
  }
}