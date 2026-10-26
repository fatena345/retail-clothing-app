import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_icons.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:geeta/widgets/custom_text.dart';

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