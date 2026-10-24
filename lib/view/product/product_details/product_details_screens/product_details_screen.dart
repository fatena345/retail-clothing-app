
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
import 'package:ui_test/model/product/product_model.dart';
import 'package:ui_test/view/product/product_details/product_details_controllers/product_details_controller.dart';
import 'package:ui_test/view/product/product_details/product_details_screens/widgets/rating_row.dart';
import 'package:ui_test/widgets/custom_elevated_button.dart';
import 'package:ui_test/widgets/custom_text.dart';
import 'package:ui_test/widgets/formatted_price.dart';

import '../../../../core/controllers/favorite/favorite_controller.dart';
import '../../../cart/cart_controllers/cart_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments as ProductModel;
    final favCtrl = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());
   final cartCtrl = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController(), permanent: true);

    return Scaffold(
      backgroundColor: AppColors.productBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.symmetric(
                horizontal: AppPaddingWidth.p20,
                vertical: AppPaddingHeight.p10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.blackText),
                  ),
                  GetBuilder<FavoriteController>(
                    builder: (_) {
                      final isFav = favCtrl.isFavorite(product.id);
                      return CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: AppRadius.r22,
                        child: IconButton(
                          onPressed: () => favCtrl.toggleFavorite(product),
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? AppColors.red : AppColors.blackText,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Image.network(
                  product.images.first,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Image.asset(AppImages.image),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppPaddingWidth.p25),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.r40),
                    topRight: Radius.circular(AppRadius.r40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: AppString.geetaMens,
                                color: AppColors.blackText,
                                fontSize: AppFontSize.s12,
                                fontWeight: AppFontWeight.regular,
                              ),
                              SizedBox(height: AppHeight.h4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text: product.title,
                                      fontSize: AppFontSize.s24,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLignes: 3,
                                    ),
                                  ),
                                  FormattedPrice(price: product.price, color: AppColors.blackText,)
                                ],
                              )
                              ,
                              SizedBox(height: AppHeight.h3),
                              RatingRow()
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: AppHeight.h15),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPaddingWidth.p8,
                            vertical: AppPaddingHeight.p4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.coolLightGrey),
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          child: GetBuilder<ProductDetailsController>(
                            init: Get.put(ProductDetailsController()),
                            builder: (controller)
                            {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.decrease();
                                    },
                                    child: const Icon(Icons.remove, size: 18),
                                  ),
                                  SizedBox(width: AppWidth.w15),
                                  CustomText(
                                    text: '${controller.quantity}',
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                  SizedBox(width: AppWidth.w15),
                                  GestureDetector(
                                    onTap: () => controller.increase(),
                                    child: const Icon(Icons.add, size: 18),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: AppColors.lightBlue,
                          child: AppIcons.upload ,
                        ),
                      ],
                    ),
                    SizedBox(height: AppHeight.h15),
                    CustomText(
                      text: AppString.description,
                      fontSize: AppFontSize.s12,
                      fontWeight: AppFontWeight.bold,
                    ),
                    SizedBox(height: AppHeight.h4),
                    CustomText(
                      text: product.description.isNotEmpty
                          ? product.description
                          : AppString.noDescription,
                      fontSize: AppFontSize.s12,
                      color: AppColors.greyText,
                      maxLignes: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppHeight.h15),
                    CustomText(
                      text: AppString.selectSize,
                      fontSize: AppFontSize.s12,
                      fontWeight: AppFontWeight.bold,
                    ),
                    SizedBox(height: AppHeight.h8),
                    GetBuilder<ProductDetailsController>(
                      builder: (controller) {
                        return Row(
                          children: controller.sizes.map((size) {
                            final isSelected = controller.selectedSize == size;
                            return GestureDetector(
                              onTap: () => controller.changeSelectedSizeColor(size: size),
                              child: Container(
                                margin: EdgeInsets.only(right: AppWidth.w10),
                                width: AppWidth.w42,
                                height: AppHeight.h42,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primary : AppColors.lightBlue,
                                  borderRadius: BorderRadius.circular(AppRadius.r10),
                                ),
                                alignment: Alignment.center,
                                child: CustomText(
                                  text: size,
                                  color: isSelected ? AppColors.white : AppColors.blackText,
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    ),
                    const Spacer(),
                    GetBuilder<ProductDetailsController>(
                      builder: (controller) {
                        return CustomElevatedButton(
                          width: double.infinity,
                          color: AppColors.primary,
                          onPressed: () {
                            cartCtrl.addToCart(
                              product: product,
                              quantity: controller.quantity,
                              size: controller.selectedSize,
                            );

                            Get.snackbar(
                              'Cart',
                              '${product.title} (${controller.selectedSize} x${controller
                                  .quantity})${AppString.addedToCart}',
                            );

                            Get.toNamed(AppRoutes.myCart);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppIcons.cartWhite,
                             // const Icon(Icons.shopping_bag_outlined, color: AppColors.white),
                              SizedBox(width: AppWidth.w10),
                              CustomText(
                                text: AppString.addToCart,
                                color: AppColors.white,
                                fontWeight: AppFontWeight.bold,
                                fontSize: AppFontSize.s11,
                              ),

                            ],
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

