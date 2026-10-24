import 'package:flutter/cupertino.dart';
import 'package:ui_test/core/constants/app_values.dart';

class DefaultValues {

  DefaultValues._();

  // padding (default)
 static   EdgeInsetsGeometry defaultPadding = EdgeInsets.only(
    top: AppPaddingHeight.p64,
    bottom: AppPaddingHeight.p26,
    right: AppPaddingWidth.p28,
   left: AppPaddingWidth.p32,

  );


 // size of icon
 static double iconInputFeildSize = AppSize.s18;
  static double iconSize = AppSize.s30;


 //auth screens  padding
  static   EdgeInsetsGeometry authHeaderPadding = EdgeInsets.only(
    top: AppPaddingHeight.p65,
    right: AppPaddingWidth.p84,
    left: AppPaddingWidth.p35,
    bottom: AppPaddingHeight.p25
  );
  static   EdgeInsetsGeometry authFormPadding = EdgeInsets.only(
    top: AppPaddingHeight.p45,
    bottom: AppPaddingHeight.p15,
    right: AppPaddingWidth.p40,
    left: AppPaddingWidth.p40,

  );
  static final double spaceBetwwenFields = AppHeight.h25;

 // border radius
    // button
    static final double buttonRadius = AppRadius.r45;
    static final double smallButtonRadius = AppRadius.r56;
    // field input
    static final double fieldInputRadius = AppRadius.r8;






}