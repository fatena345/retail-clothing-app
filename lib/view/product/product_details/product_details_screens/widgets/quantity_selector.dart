import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/view/product/product_details/product_details_controllers/product_details_controller.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:get/get.dart';
class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key ,required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p8,
        vertical: AppPaddingHeight.p4,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.coolLightGrey),
        borderRadius: BorderRadius.circular(AppRadius.r8),
      ),
      child: GetBuilder<ProductDetailsController>(
        id: 'quantity',
        builder: (c) => Row(
          children: [
            GestureDetector(
              onTap: c.decrease,
              child: const Icon(Icons.remove, size: 18),
            ),
            SizedBox(width: AppWidth.w15),
            CustomText(
              text: '${c.quantity}',
              fontWeight: AppFontWeight.bold,
            ),
            SizedBox(width: AppWidth.w15),
            GestureDetector(
              onTap: c.increase,
              child: const Icon(Icons.add, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
