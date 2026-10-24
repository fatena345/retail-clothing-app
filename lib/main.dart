import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ui_test/core/bindings/initial_bindings.dart';
import 'package:ui_test/core/routes/app_pages.dart';
import 'package:ui_test/core/routes/app_routes.dart';
import 'package:ui_test/view/home/home_screens/home_screen.dart';


void main() {
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

