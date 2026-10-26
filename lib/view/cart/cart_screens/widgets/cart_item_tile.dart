
import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_images.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/controllers/cart/cart_controller.dart';
import 'package:geeta/model/cart/cart_item_model.dart';
import 'package:geeta/view/cart/cart_screens/widgets/quantity_box.dart';
import 'package:geeta/widgets/custom_text.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key,required this.item, required this.controller});

  final CartItemModel item;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    final product = item.product;

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
                  children: [
                    Expanded(
                      child: CustomText(
                        text: product.name,
                        color: AppColors.primary,
                        fontSize: AppFontSize.s15,
                        fontWeight: AppFontWeight.bold,
                        maxLignes: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.removeFromCart(item),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.greyText,
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: '${AppString.geetaCollection} • Size: ${item.size}',
                  color: AppColors.greyText,
                  fontSize: AppFontSize.s11,
                ),
                SizedBox(height: AppHeight.h10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: '\$${product.price.toStringAsFixed(2)} USD',
                      fontSize: AppFontSize.s14,
                      fontWeight: AppFontWeight.bold,
                    ),
                    QuantityBox(item: item, controller: controller),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
