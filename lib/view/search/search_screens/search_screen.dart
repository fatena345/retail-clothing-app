import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/model/product/product_model.dart';
import 'package:ui_test/view/home/home_controllers/home_controller.dart';
import 'package:ui_test/widgets/custom_text.dart';
import 'package:ui_test/widgets/products_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCtrl = TextEditingController(text: 'Hoodies');
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<HomeController>()) {
      filteredProducts = Get.find<HomeController>().products;
    }
  }

  void _onSearch(String val) {
    if (!Get.isRegistered<HomeController>()) return;
    final all = Get.find<HomeController>().products;
    setState(() {
      filteredProducts = all
          .where((p) => p.title.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.productBackground,
                borderRadius: BorderRadius.circular(AppRadius.r12),
              ),
              child: TextField(
                controller: searchCtrl,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: AppColors.greyText),
                  border: InputBorder.none,
                  hintText: AppString.hints['search'],
                  contentPadding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p12),
                ),
              ),
            ),
            SizedBox(height: AppHeight.h15),
            CustomText(
              text:
              '${filteredProducts.length} ${AppString.itemsFoundFor} "${searchCtrl.text}"',
              color: AppColors.greyText,
              fontSize: AppFontSize.s12,
            ),
            SizedBox(height: AppHeight.h15),
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(child: CustomText(text: AppString.noData))
                  : ProductsGrid(products: filteredProducts),
            ),
          ],
        ),
      ),
    );
  }
}