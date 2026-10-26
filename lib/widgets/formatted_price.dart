import 'package:flutter/cupertino.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_string.dart';

import '../core/constants/app_fonts.dart';


class FormattedPrice extends StatelessWidget {
  final num price;
  final Color? color;
  const FormattedPrice({
    super.key,
    required this.price,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    final parts = price.toStringAsFixed(2).split('.');

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '\$${parts[0]}',
            style:  TextStyle(
              fontSize: AppFontSize.s18,
              color: color?? AppColors.greyText,
              fontWeight: AppFontWeight.extraBoldPro
            , fontFamily: AppFontFamily.lato,
            ),

          ),
          TextSpan(
            text: '.${parts[1]}',
            style: TextStyle(fontSize: AppFontSize.s14,
                fontFamily: AppFontFamily.lato,
                color: color ??  AppColors.greyText,
                fontWeight: AppFontWeight.extraBoldPro),
          ),
          TextSpan(
            text: AppString.dollar,
            style: TextStyle(fontSize: AppFontSize.s12,
                fontFamily: AppFontFamily.lato,
                color:color ??  AppColors.greyText,
                fontWeight: AppFontWeight.extraBoldPro),
          ),
        ],
      ),
    );
  }
}