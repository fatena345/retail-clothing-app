import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_icons.dart';
import 'package:geeta/core/constants/app_values.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../widgets/custom_text.dart';

class HeaderSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: AppString.appTitle,
          fontSize: AppFontSize.s24,
        ),
        Row(
          spacing: AppWidth.w10,
          children: [
            AppIcons.notifications,
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.myCart),
              child: AppIcons.cart,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.favorite),
              child: AppIcons.favorite,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.search),
              child: AppIcons.search,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.profile),
              child: AppIcons.menu,
            ),
          ],
        ),
      ],
    );
  }
}

