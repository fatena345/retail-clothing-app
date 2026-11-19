import 'package:geeta/core/services/sqflite/sqflite_service.dart';
import 'package:geeta/view/auth/register/register_controllers/register_draft_controller.dart';
import 'package:get/get.dart';
import 'package:geeta/view/auth/register/register_controllers/register_controller.dart';


class RegisterBinding extends Bindings{
  @override
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(  () => RegisterDraftController(Get.find<SqfliteService>()) , fenix: true);
  }

}