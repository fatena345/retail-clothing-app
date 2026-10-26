import 'package:flutter/cupertino.dart';
import 'package:geeta/core/constants/app_colors.dart';

import '../../core/constants/app_fonts.dart';

class CustomText extends StatelessWidget{
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? textOverflow;
  final int? maxLignes;
  final TextAlign? align;
  final TextDecoration? textDecoration;
  CustomText({
    required this.text,
    this.textOverflow,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLignes,
    this.align,
    this.textDecoration
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLignes,
      textAlign: align ?? TextAlign.start,
      style:TextStyle(
        fontSize: fontSize ?? AppFontSize.s14,
        fontFamily: AppFontFamily.lato,
        fontWeight: fontWeight ?? AppFontWeight.extraBoldPro,
        color: color ?? AppColors.blackText,
        overflow: textOverflow,
        decoration: textDecoration ?? TextDecoration.none,
      ) ,

    );
  }

}