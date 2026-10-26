
import 'package:flutter/material.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/view/search/search_controller/product_search_controller.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key,required this.controller});

  final ProductSearchController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.productBackground,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: TextField(
        controller: controller.searchCtrl,
        onChanged: controller.onQueryChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: AppColors.greyText),
          suffixIcon: IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.close, color: AppColors.greyText),
          ),
          border: InputBorder.none,
          hintText: AppString.hints['search'],
          contentPadding: EdgeInsets.symmetric(
            vertical: AppPaddingHeight.p12,
          ),
        ),
      ),
    );
  }
}

