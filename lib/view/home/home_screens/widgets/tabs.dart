import 'package:flutter/material.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/widgets/custom_text.dart';

class Tabs extends StatelessWidget
{
   final List<String> tabsNames = [
    AppString.popular,
    AppString.mens,
     AppString.womens,
     AppString.sale,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: AppWidth.w44,
          children: 
           List.generate(tabsNames.length, (index) => CustomText(text: tabsNames[index], color: AppColors.greyText, fontWeight: AppFontWeight.extraBold, fontSize: AppFontSize.s17,) )
          ,
        ),
        Container(height: AppHeight.h1, width: double.infinity, color: AppColors.coolLightGrey,),
      ],
    );
  }

}