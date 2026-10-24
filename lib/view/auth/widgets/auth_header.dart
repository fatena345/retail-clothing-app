import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_icons.dart';
import 'package:ui_test/core/constants/app_images.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/constants/default_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/widgets/custom_text.dart';

class AuthHeader extends StatelessWidget {
   final bool isLogin;
  final double height;
  final String title;
  final String subTitle;
  final String textButton;

  const AuthHeader({
    super.key,
    required this.isLogin,
    required this.title,
    required this.subTitle,
    required this.height,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
     // height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage( AppImages.authBackground,),
           fit: BoxFit.fill
        ),
      ),
      child: Padding(
        padding: DefaultValues.authHeaderPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: (){
               Get.back();
                },
                icon: AppIcons.arrowLeft),
            if(isLogin)
            SizedBox(height: AppHeight.h52,),
            if(!isLogin)
              SizedBox(height: AppHeight.h82,),
            CustomText(text: title, fontSize: AppFontSize.s24,color: AppColors.white,),
            if(isLogin)
            SizedBox(height: AppHeight.h30,),
            if(!isLogin)
              SizedBox(height: AppHeight.h8,),
            if(isLogin)
            CustomText(text: subTitle, fontWeight: AppFontWeight.bold,color: AppColors.white ),
            if(!isLogin)
              Row(
                spacing: AppWidth.w3,
                children: [
                  CustomText(text: subTitle, fontWeight: AppFontWeight.bold,color: AppColors.white ),
                  TextButton(onPressed: (){
                    Get.toNamed(AppRoutes.login);
                  }, child:CustomText(text: AppString.login, fontWeight: AppFontWeight.bold,color: AppColors.white, textDecoration: TextDecoration.underline, ),
                       )
                ],
              ),
            if(isLogin)
              SizedBox(height: AppHeight.h65,),
            if(!isLogin)
              SizedBox(height: AppHeight.h65,),
            TextButton(onPressed: ()
                {
                  textButton == AppString.login?
                      Get.toNamed(AppRoutes.login)
                      :
                  Get.toNamed(AppRoutes.register);
                }, child: CustomText(text: textButton, fontSize: AppFontSize.s18,color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}
