import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geeta/core/services/firebase/notifications_service.dart';
import 'package:geeta/core/services/storage_manager.dart';
import 'package:geeta/core/services/token_storage.dart';
import 'package:geeta/firebase_options.dart';
import 'package:get/get.dart';
import 'package:geeta/core/bindings/initial_bindings.dart';
import 'package:geeta/core/routes/app_pages.dart';
import 'package:geeta/core/routes/app_routes.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final storage = await Get.putAsync(() => StorageManager().init());
  await Get.putAsync(() => TokenStorage(storage).init());

  final notifications = Get.put(NotificationsService());
  await notifications.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414,875),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
            initialRoute: AppRoutes.splash,
            getPages: AppPages.getPages,
            initialBinding: InitialBindings(),
            defaultTransition: Transition.fadeIn,
            debugShowCheckedModeBanner: true,
          //home: HomeScreen(),
        ),

    );
  }
}

