import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/core/constants/default_values.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/home/home_controllers/home_controller.dart';

import 'package:ui_test/view/home/home_screens/widgets/filter_section.dart';
import 'package:ui_test/view/home/home_screens/widgets/header_section.dart';
import 'package:ui_test/view/home/home_screens/widgets/tabs.dart';
import 'package:ui_test/widgets/custom_text.dart';
import 'package:ui_test/widgets/products_grid.dart';

import '../../../core/constants/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.toNamed(AppRoutes.createProduct);
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: GetBuilder<HomeController>(
        init: Get.find<HomeController>(),
        builder: (controller) {
          return ModalProgressHUD(
            inAsyncCall: controller.isDeleting,
            progressIndicator: const CircularProgressIndicator(color: AppColors.primary),
            child: Padding(
              padding: DefaultValues.defaultPadding,
              child: Column(
                spacing: AppHeight.h30,
                children: [
                  // Header Section
                  HeaderSection(),

                  Tabs(),
                  FilterSection(),

                  Expanded(
                    child: controller.status.isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                        : controller.status.isNoData
                        ? Center(child: CustomText(text: AppString.noData))
                        : controller.status.isNoInternet
                        ? Center(child: CustomText(text: AppString.noInternet))
                        : controller.status.isServerError
                        ? Center(child: CustomText(text: AppString.wrong))
                        : controller.status.isAnotherError
                        ? Center(child: CustomText(text: AppString.antherError))
                        : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: controller.getProducts,
                      child: ProductsGrid(products: controller.products),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }



}