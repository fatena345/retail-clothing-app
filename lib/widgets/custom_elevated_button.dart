import 'package:flutter/material.dart';
import 'package:geeta/core/constants/default_values.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_values.dart';



class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final Color? shadowColor;
  final Color? borderColor;
  final BorderSide? borderSide;
  final double? width;
  final Widget? child;
  final double? elevation;
  final double? height;
  final double? marginTop;
  final double? marginBottom;
  final double? marginStart;
  final double? marginEnd;
  final double? borderRadius;
  final bool isSmallButton;

  final Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final bool? loading;
  final bool? notEnable;
  final bool showCircle;
  final Gradient? gradient;





  const CustomElevatedButton({
    super.key,
    this.isSmallButton = false,
    this.borderRadius,
    this.width,
    this.height,
    required this.onPressed,
    this.borderSide,
    this.elevation,
    this.child,
    this.padding,
    this.loading,
    this.notEnable,
    this.color,
    this.shadowColor,
    this.marginTop,
    this.marginBottom,
    this.marginStart,
    this.marginEnd,
    this.showCircle = true,
    this.gradient,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: notEnable ?? false,
      child:Container(
        margin: EdgeInsetsDirectional.only(
          top: marginTop ?? 0,
          bottom: marginBottom ?? 0,
          start: marginStart ?? 0,
          end: marginEnd ?? 0,
        ),
        height: height ?? AppHeight.h54,
        width: width ?? (isSmallButton? AppWidth.w222 : AppWidth.w354),
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all (color: borderColor ?? AppColors.primary),
          borderRadius: BorderRadius.circular(borderRadius ?? (isSmallButton? DefaultValues.smallButtonRadius : DefaultValues.buttonRadius) ),
        ),

        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: padding,
            elevation: elevation,
            backgroundColor: color ?? (isSmallButton? AppColors.transparent :  AppColors.primary),
            shadowColor: shadowColor,

            /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.r56),
              side: borderSide ?? BorderSide.none,
            ),*/
          ),
          child: child,
        ),
      ),
    );
  }
}
