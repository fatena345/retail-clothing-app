import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_fonts.dart';
import '../../../../../core/constants/app_values.dart';
import '../../../../../widgets/custom_text.dart';

class RatingRow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 4; i++)
          Icon(Icons.star, color: AppColors.amber, size: AppSize.s12),
        Icon(Icons.star, color: AppColors.greyText,size: AppSize.s12),
        SizedBox(width: AppWidth.w5),
        CustomText(
          text: '(4.5)',
          fontSize: AppFontSize.s11,
          color: AppColors.greyText,
        ),
      ],
    );
  }
}