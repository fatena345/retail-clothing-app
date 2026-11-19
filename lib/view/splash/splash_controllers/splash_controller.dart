import 'package:get/get.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/core/services/firebase/firebase_auth_service.dart';

class SplashController extends GetxController {
  final FirebaseAuthService _auth = Get.find();


 
bool _navigated = false;

@override
void onReady() {
  super.onReady();
  _decideNextRoute();
}

Future<void> _decideNextRoute() async {
  await Future.delayed(const Duration(seconds: 2));
  goNext();
}

Future<void> goNext() async {
  if (_navigated) return;   
  _navigated = true;

 
  Get.offAllNamed( _auth.isLoggedIn ? AppRoutes.home : AppRoutes.welcome);
}
}