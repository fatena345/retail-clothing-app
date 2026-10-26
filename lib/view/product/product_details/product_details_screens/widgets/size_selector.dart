import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/view/product/product_details/product_details_controllers/product_details_controller.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:get/get.dart';
class SizeSelector extends StatelessWidget {
  const SizeSelector({super.key,required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      id: 'size',
      builder: (c) => Row(
        children: c.sizes.map((size) {
          final isSelected = c.selectedSize == size;
          return GestureDetector(
            onTap: () => c.changeSelectedSize(size),
            child: Container(
              margin: EdgeInsetsDirectional.only(end: AppWidth.w10),
              width: AppWidth.w42,
              height: AppHeight.h42,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.lightBlue,
                borderRadius: BorderRadius.circular(AppRadius.r10),
              ),
              alignment: Alignment.center,
              child: CustomText(
                text: size,
                color: isSelected ? AppColors.white : AppColors.blackText,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
