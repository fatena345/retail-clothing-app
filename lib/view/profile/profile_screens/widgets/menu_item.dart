import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:get/get.dart';


class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.route,
    this.onTap,
    this.fontSize,
    this.verticalPadding,
  });

  final IconData icon;
  final String title;
  final String? route;
  final VoidCallback? onTap;
  final double? fontSize;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? (route != null ? () => Get.toNamed(route!) : null),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? AppPaddingHeight.p18,
        ),
        child: Row(
          children: [
            // عرض ثابت حتى تتراصف كل النصوص عمودياً
            SizedBox(
              width: AppWidth.w30,
              child: Icon(icon, color: AppColors.white, size: 24),
            ),
            SizedBox(width: AppWidth.w15),
            Expanded(
              child: CustomText(
                text: title,
                color: AppColors.white,
                fontSize: fontSize ?? AppFontSize.s15,
                fontWeight: AppFontWeight.bold,
                maxLignes: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}