import 'package:geeta/view/search/search_controller/product_search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductSearchController());
  }
}