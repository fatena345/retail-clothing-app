import 'package:flutter/material.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_values.dart';

import 'default_values.dart';

class AppIcons {

  AppIcons._();


  // auth icons
  static final Icon arrowLeft = Icon(Icons.arrow_back, size:DefaultValues.iconSize, color: AppColors.white,);
  static final Icon email = Icon(Icons.email_outlined, size:DefaultValues.iconInputFeildSize, color: AppColors.blackText,);
  static final  Icon password = Icon(Icons.lock_outline, size:DefaultValues.iconInputFeildSize, color: AppColors.blackText);
  static final Icon person = Icon(Icons.person_outline_rounded, size:DefaultValues.iconInputFeildSize, color: AppColors.blackText);

  // home icons
  static final Icon notifications = Icon(Icons.notifications_none, size:  DefaultValues.iconSize,);
  static final  Icon cart = Icon(Icons.shopping_bag_outlined, size:  DefaultValues.iconSize,);
  static final  Icon cartWhite = Icon(Icons.shopping_bag_outlined , color: AppColors.white,);
  static final Icon favorite = Icon(Icons.favorite_border, size:DefaultValues.iconSize);
  static final Icon favoriteFilled = Icon(Icons.favorite, size:DefaultValues.iconSize);
  static final Icon search = Icon(Icons.search, size:  DefaultValues.iconSize,);
  static final  Icon menu = Icon(Icons.list, size: DefaultValues.iconSize,);
  static final Icon squareBold = Icon(Icons.square, size:DefaultValues.iconSize,);
  static final   filter =Image.asset("assets/icons/filter_icon.png" , width: AppWidth.w24, height: AppHeight.h24,);
  static final Icon gridEmpty = Icon(Icons.grid_view_outlined, size:DefaultValues.iconSize,);
  static final Icon upload = Icon(Icons.upload_outlined, color: AppColors.blackText, size: DefaultValues.iconSize,);
  static final Icon close = Icon(
    Icons.close,
    color: AppColors.white,
    size: DefaultValues.iconSize,
  );
}