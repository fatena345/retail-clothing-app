import 'package:flutter/material.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_icons.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/constants/default_values.dart';
import 'package:ui_test/widgets/custom_text.dart';

class FilterSection  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: AppWidth.w10,
          children: [
            CustomText(text: AppString.filterAndSort, fontSize: AppFontSize.s14, ),
            AppIcons.filter
          ],
        ),
        Row(
          spacing: AppWidth.w10,
          children: [
            AppIcons.gridEmpty,
            AppIcons.squareBold
          ],
        ),
      ],
    );
  }
  
  
}