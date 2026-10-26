import 'package:geeta/core/controllers/cart/cart_controller.dart';
import 'package:geeta/core/controllers/favorite/favorite_controller.dart';
import 'package:geeta/view/auth/auth_controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';
import 'package:geeta/core/services/firebase/firestore_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
  Get.put(FirebaseAuthService(), permanent: true);
  Get.put(FirestoreService(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);
  Get.put(CartController(), permanent: true);
  }
}