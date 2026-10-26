import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/view/home/home_controllers/home_controller.dart';

import 'package:geeta/view/home/home_screens/widgets/filter_section.dart';
import 'package:geeta/view/home/home_screens/widgets/header_section.dart';
import 'package:geeta/view/home/home_screens/widgets/tabs.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:geeta/widgets/products_grid.dart';

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
            progressIndicator: SpinKitThreeBounce(
  color: AppColors.primary,
  size: DefaultValues.indicatorSize,
),
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
                        ?  Center(
                      child: SpinKitThreeBounce(
  color: AppColors.primary,
  size: DefaultValues.indicatorSize,
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