
import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/controllers/cart/cart_controller.dart';
import 'package:geeta/model/cart/cart_item_model.dart';
import 'package:geeta/widgets/custom_text.dart';

class QuantityBox extends StatelessWidget {
  const QuantityBox({super.key,required this.item, required this.controller});

  final CartItemModel item;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: () => controller.decrementQuantity(item),
            child: const Icon(Icons.remove, size: 16),
          ),
          SizedBox(width: AppWidth.w10),
          CustomText(
            text: '${item.quantity}',
            fontWeight: AppFontWeight.bold,
          ),
          SizedBox(width: AppWidth.w10),
          GestureDetector(
            onTap: () => controller.incrementQuantity(item),
            child: const Icon(Icons.add, size: 16),
          ),
        ],
      ),
    );
  }
}