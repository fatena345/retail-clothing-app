import 'package:flutter/material.dart';
import 'package:geeta/view/search/search_controller/product_search_controller.dart';
import 'package:geeta/view/search/search_screens/widgets/search_field.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/view/home/home_controllers/home_controller.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:geeta/widgets/products_grid.dart';

class SearchScreen extends GetView<ProductSearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: AppColors.blackText),
        ),
        title: CustomText(
          text: AppString.findProducts,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p20),
        child: Column(
          children: [
            SizedBox(height: AppHeight.h10),
            SearchField(controller: controller),
            SizedBox(height: AppHeight.h15),
            // يسمع للـ controller تبع البحث وللهوم (لو تغيّرت المنتجات)
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (_) => GetBuilder<ProductSearchController>(
                  builder: (c) {
                    final results = c.results;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (c.hasQuery) ...[
                          CustomText(
                            text:
                                '${results.length} ${AppString.itemsFoundFor} "${c.query.trim()}"',
                            color: AppColors.greyText,
                            fontSize: AppFontSize.s12,
                          ),
                          SizedBox(height: AppHeight.h15),
                        ],
                        Expanded(
                          child: results.isEmpty
                              ? Center(
                                  child: CustomText(text: AppString.noData),
                                )
                              : ProductsGrid(products: results),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

