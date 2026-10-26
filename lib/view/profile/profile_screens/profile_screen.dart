import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/view/profile/profile_screens/widgets/menu_item.dart';
import 'package:geeta/view/profile/profile_screens/widgets/profile_header.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:geeta/core/routes/app_routes.dart';

import 'package:geeta/view/profile/profile_controllers/profile_controller.dart';


class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  static const double _panelWidthFactor = 0.71;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * _panelWidthFactor;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: Colors.transparent, // مهم: عشان الهوم يبين
      body: Stack(
        children: [
          // الخلفية: blur + طبقة بيضاء شفافة، والضغط عليها بيسكّر
          Positioned.fill(
            child: GestureDetector(
              onTap: Get.back,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: AppColors.white.withAlpha(170)),
              ),
            ),
          ),

          // اللوحة: بتنزلق من الجهة
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1, end: 0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              builder: (_, t, child) => FractionalTranslation(
                translation: Offset(isRtl ? -t : t, 0),
                child: child,
              ),
              child: _ProfilePanel(width: width),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePanel extends GetView<ProfileController> {
  const _ProfilePanel({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            AppColors.profileGradientStart,
            AppColors.profileGradientEnd,
          ],
        ),
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(AppRadius.r40),
          bottomEnd: Radius.circular(AppRadius.r40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: AppPaddingWidth.p25,
            end: AppPaddingWidth.p25,
            top: AppPaddingHeight.p15,
            bottom: AppPaddingHeight.p25,
          ),
          child: GetBuilder<ProfileController>(
            builder: (c) {
              if (c.status.isLoading) {
                return Center(
                  child: SpinKitThreeBounce(
                    color: AppColors.white,
                    size: DefaultValues.indicatorSize,
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // زر الإغلاق
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.close,
                          color: AppColors.white, size: 28),
                    ),
                  ),
                  SizedBox(height: AppHeight.h30),
                  ProfileHeader(user: c.profile),
                  SizedBox(height: AppHeight.h30),

                  // القائمة (قابلة للتمرير للشاشات الصغيرة)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MenuItem(
                            icon: Icons.shopping_bag_outlined,
                            title: AppString.orders,
                            route: AppRoutes.myCart,
                          ),
                          MenuItem(
                            icon: Icons.favorite_border,
                            title: AppString.wishlist,
                            route: AppRoutes.favorite,
                          ),
                          MenuItem(
                            icon: Icons.location_on_outlined,
                            title: AppString.deliveryAddress,
                          ),
                          MenuItem(
                            icon: Icons.credit_card_outlined,
                            title: AppString.paymentMethods,
                            route: AppRoutes.payment,
                          ),
                          MenuItem(
                            icon: Icons.confirmation_number_outlined,
                            title: AppString.promoCord,
                          ),
                          MenuItem(
                            icon: Icons.notifications_none,
                            title: AppString.notifications,
                          ),
                          MenuItem(
                            icon: Icons.help_outline,
                            title: AppString.help,
                          ),
                          MenuItem(
                            icon: Icons.info_outline,
                            title: AppString.about,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // تسجيل الخروج: أصغر وبحروف كبيرة متل التصميم
                  MenuItem(
                    icon: Icons.logout,
                    title: AppString.logout.toUpperCase(),
                    onTap: c.logout,
                    fontSize: AppFontSize.s11,
                    verticalPadding: 0,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
