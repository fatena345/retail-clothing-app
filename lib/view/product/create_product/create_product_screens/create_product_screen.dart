import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ui_test/core/constants/app_colors.dart';
import 'package:ui_test/core/constants/app_fonts.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/constants/app_values.dart';
import 'package:ui_test/view/home/home_controllers/home_controller.dart';
import 'package:ui_test/view/product/create_product/create_product_controllers/create_product_controller.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';
import 'package:ui_test/widgets/form/custom_input_field.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController catIdCtrl = TextEditingController(text: '1');
  final TextEditingController imgCtrl = TextEditingController(
    text: 'https://placeimg.com/640/480/any',
  );

  @override
  void dispose() {
    titleCtrl.dispose();
    priceCtrl.dispose();
    descCtrl.dispose();
    catIdCtrl.dispose();
    imgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProductController>(
      init: Get.find<CreateProductController>(),
      builder: (controller) {
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
              text: AppString.addNewProduct,
              fontSize: AppFontSize.s18,
              fontWeight: AppFontWeight.bold,
            ),
            centerTitle: true,
          ),
          body: ModalProgressHUD(
            inAsyncCall: controller.status.isLoading,
            progressIndicator: const CircularProgressIndicator(color: AppColors.primary),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppPaddingWidth.p25,
                vertical: AppPaddingHeight.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    controller: titleCtrl,
                    hintText: AppString.hints['title']!,
                    title: AppString.productTitle,
                    req: true,
                  ),
                  SizedBox(height: AppHeight.h15),
                  CustomInputField(
                    controller: priceCtrl,
                    hintText: AppString.hints['price']!,
                    title: AppString.priceInDollar,
                    textInputType: TextInputType.number,
                    req: true,
                  ),
                  SizedBox(height: AppHeight.h15),
                  CustomInputField(
                    controller: descCtrl,
                    hintText: AppString.hints['description']!,
                    title: AppString.description,
                    req: true,
                  ),
                  SizedBox(height: AppHeight.h15),
                  CustomInputField(
                    controller: catIdCtrl,
                    hintText: AppString.hints['categoryId']!,
                    title: AppString.categoryId,
                    textInputType: TextInputType.number,
                    req: true,
                  ),
                  SizedBox(height: AppHeight.h15),
                  CustomInputField(
                    controller: imgCtrl,
                    hintText: AppString.hints['imageUrl']!,
                    title: AppString.imageUrl,
                    req: true,
                  ),
                  SizedBox(height: AppHeight.h35),
                  CustomElevatedButton(
                    width: double.infinity,
                    color: AppColors.primary,
                    onPressed: () async {
                      if (titleCtrl.text.trim().isEmpty ||
                          priceCtrl.text.trim().isEmpty ||
                          descCtrl.text.trim().isEmpty) {
                        Get.snackbar('Validation', 'Please fill all required fields');
                        return;
                      }

                      final price = num.tryParse(priceCtrl.text.trim()) ?? 0;
                      final catId = int.tryParse(catIdCtrl.text.trim()) ?? 1;

                      final success = await controller.createProduct(
                        title: titleCtrl.text.trim(),
                        price: price,
                        description: descCtrl.text.trim(),
                        categoryId: catId,
                        image: imgCtrl.text.trim(),
                      );

                      if (success) {
                        Get.snackbar('Success', AppString.productCreatedSuccess);
                        if (Get.isRegistered<HomeController>()) {
                          Get.find<HomeController>().getProducts();
                        }
                        Get.back();
                      } else {
                        Get.snackbar(
                          'Failed',
                          controller.status.message ?? AppString.failedCreateProduct,
                        );
                      }
                    },
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
        );
      },
    );
  }
}