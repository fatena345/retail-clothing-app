import 'package:get/get.dart';
import 'package:ui_test/core/bindings/create_product_binding.dart';
import 'package:ui_test/core/bindings/favorite_binding.dart';
import 'package:ui_test/core/bindings/home_binding.dart';
import 'package:ui_test/core/bindings/login_binding.dart';
import 'package:ui_test/core/bindings/profile_binding.dart';
import 'package:ui_test/core/bindings/register_binding.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/auth/login/login_screens/login_screen.dart';
import 'package:ui_test/view/auth/register/register_screens/register_screen.dart';
import 'package:ui_test/view/cart/cart_screens/my_cart_screen.dart';
import 'package:ui_test/view/favorite/favorite_screens/favorite_screen.dart';
import 'package:ui_test/view/home/home_screens/home_screen.dart';

import 'package:ui_test/view/payment/payment_screens/payment_screen.dart';
import 'package:ui_test/view/product/create_product/create_product_screens/create_product_screen.dart';
import 'package:ui_test/view/product/product_details/product_details_screens/product_details_screen.dart';
import 'package:ui_test/view/profile/profile_screens/profile_screen.dart';
import 'package:ui_test/view/search/search_screens/search_screen.dart';
import 'package:ui_test/view/splash/splash_screens/splash_screen.dart';
import 'package:ui_test/view/welcome/welcome_screens/welcome_screen.dart';

import '../../view/order_status/order_status_screen/order_failed_screen.dart';
import '../../view/order_status/order_status_screen/order_success_screen.dart';
import '../bindings/cart_binding.dart';
import '../bindings/product_details_binding.dart';

class AppPages {
  static final getPages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.myCart,
      page: () => const MyCartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: () => const FavoriteScreen(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
    ),
    GetPage(
      name: AppRoutes.success,
      page: () => const OrderSuccessScreen(),
    ),
    GetPage(
      name: AppRoutes.failedPlacing,
      page: () => const OrderFailedScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.createProduct,
      page: () => const CreateProductScreen(),
      binding: CreateProductBinding(),
    ),
  ];
}