import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/profile/profile_controllers/profile_controller.dart';
import 'package:ui_test/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7B52F2),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          init: Get.find<ProfileController>(),
          builder: (controller) {
            if (controller.status.isLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.white));
            }

            if (controller.status.isNoInternet) {
              return Center(child: CustomText(text: AppString.noInternet, color: AppColors.white));
            }

            final user = controller.profile;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPaddingWidth.p25,
                vertical: AppPaddingHeight.p15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close, color: AppColors.white, size: 28),
                    ),
                  ),
                  SizedBox(height: AppHeight.h20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppRadius.r30,
                        backgroundImage: NetworkImage(
                          user?.avatar ?? 'https://api.lorem.space/image/face?w=640&h=480',
                        ),
                      ),
                      SizedBox(width: AppWidth.w15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: user?.name ?? 'Varat Singh Sh',
                                    fontSize: AppFontSize.s18,
                                    fontWeight: AppFontWeight.bold,
                                    color: AppColors.white,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: AppWidth.w8),
                                const Icon(Icons.edit, color: AppColors.white, size: 16),
                              ],
                            ),
                            SizedBox(height: AppHeight.h4),
                            CustomText(
                              text: user?.email ?? 'jr.varat@gmail.com',
                              fontSize: AppFontSize.s12,
                              color: AppColors.white.withAlpha(200),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppHeight.h40),
                  _buildMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: AppString.orders,
                    onTap: () => Get.toNamed(AppRoutes.myCart),
                  ),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    title: AppString.wishlist,
                    onTap: () => Get.toNamed(AppRoutes.favorite),
                  ),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: AppString.deliveryAddress,
                  ),
                  _buildMenuItem(
                    icon: Icons.credit_card_outlined,
                    title: AppString.paymentMethods,
                    onTap: () => Get.toNamed(AppRoutes.payment),
                  ),
                  _buildMenuItem(
                    icon: Icons.confirmation_number_outlined,
                    title: AppString.promoCord,
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_none,
                    title: AppString.notifications,
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: AppString.help,
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: AppString.about,
                  ),
                  const Spacer(),
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: AppString.logout,
                    onTap: () async {
                      await controller.logout();
                      Get.offAllNamed(AppRoutes.welcome);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: AppColors.white, size: 22),
            SizedBox(width: AppWidth.w15),
            CustomText(
              text: title,
              color: AppColors.white,
              fontSize: AppFontSize.s15,
              fontWeight: AppFontWeight.semiBold,
            ),
          ],
        ),
      ),
    );
  }
}