import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geeta/view/product/create_product/create_product_controller/create_product_controller.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:geeta/core/constants/app_colors.dart';
import 'package:geeta/core/constants/app_fonts.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/core/constants/default_values.dart';
import 'package:geeta/widgets/custom_elevated_button.dart';
import 'package:geeta/widgets/custom_text.dart';
import 'package:geeta/widgets/form/custom_input_field.dart';

class CreateProductScreen extends GetView<CreateProductController> {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProductController>(
      builder: (c) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back, color: AppColors.blackText),
          ),
          title: CustomText(
            text: AppString.addNewProduct,
            fontSize: AppFontSize.s18,
            fontWeight: AppFontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          inAsyncCall: c.isSaving,
          progressIndicator: SpinKitThreeBounce(
            color: AppColors.primary,
            size: DefaultValues.indicatorSize,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddingWidth.p25,
              vertical: AppPaddingHeight.p20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  controller: c.titleCtrl,
                  hintText: AppString.hints['title']!,
                  title: AppString.productTitle,
                  req: true,
                ),
                SizedBox(height: AppHeight.h15),
                CustomInputField(
                  controller: c.priceCtrl,
                  hintText: AppString.hints['price']!,
                  title: AppString.priceInDollar,
                  textInputType: TextInputType.number,
                  req: true,
                ),
                SizedBox(height: AppHeight.h15),
                CustomInputField(
                  controller: c.descCtrl,
                  hintText: AppString.hints['description']!,
                  title: AppString.description,
                  req: true,
                ),
                SizedBox(height: AppHeight.h15),
                CustomInputField(
                  controller: c.catIdCtrl,
                  hintText: AppString.hints['categoryId']!,
                  title: AppString.categoryId,
                  textInputType: TextInputType.number,
                  req: true,
                ),
                SizedBox(height: AppHeight.h15),
                CustomInputField(
                  controller: c.imgCtrl,
                  hintText: AppString.hints['imageUrl']!,
                  title: AppString.imageUrl,
                  req: true,
                ),
                SizedBox(height: AppHeight.h35),
                CustomElevatedButton(
                  width: double.infinity,
                  color: AppColors.primary,
                  onPressed: c.submit,
                  child: CustomText(
                    text: AppString.createProduct,
                    color: AppColors.white,
                    fontSize: AppFontSize.s14,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}