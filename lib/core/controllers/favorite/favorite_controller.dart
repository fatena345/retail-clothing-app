import 'dart:convert';
import 'package:get/get.dart';
import 'package:ui_test/core/constants/app_string.dart';
import 'package:ui_test/core/services/storage_manager.dart';
import 'package:ui_test/model/product/product_model.dart';

class FavoriteController extends GetxController {
  static const String _favoriteKey = 'user_favorite_products';
  List<ProductModel> favoriteList = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    isLoading = true;
    update();

    final storage = await StorageManager.getInstance();
    final jsonStrings = await storage.getStringList(key: _favoriteKey);

    if (jsonStrings != null && jsonStrings.isNotEmpty) {
      favoriteList = jsonStrings.map((str) {
        return ProductModel.fromJson(jsonDecode(str));
      }).toList();
    } else {
      favoriteList = [];
    }

    isLoading = false;
    update();
  }

  bool isFavorite(int productId) {
    return favoriteList.any((element) => element.id == productId);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final storage = await StorageManager.getInstance();
    if (isFavorite(product.id)) {
      favoriteList.removeWhere((element) => element.id == product.id);
      Get.snackbar('Favorite', '${product.title} ${AppString.removedSuccess}');
    } else {
      favoriteList.add(product);
      Get.snackbar('Favorite', '${product.title} ${AppString.addedToFavorite}');
    }

    final jsonStrings = favoriteList.map((p) => jsonEncode(p.toJson())).toList();
    await storage.saveData(key: _favoriteKey, value: jsonStrings);
    update();
  }

  Future<void> removeFavorite(int productId) async {
    final storage = await StorageManager.getInstance();
    favoriteList.removeWhere((element) => element.id == productId);
    final jsonStrings = favoriteList.map((p) => jsonEncode(p.toJson())).toList();
    await storage.saveData(key: _favoriteKey, value: jsonStrings);
    update();
  }
}