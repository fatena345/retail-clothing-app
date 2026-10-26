import 'package:geeta/core/controllers/cart/cart_controller.dart';
import 'package:get/get.dart';
import 'package:geeta/core/constants/app_string.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:geeta/model/product/product_model.dart';
import 'package:geeta/core/controllers/favorite/favorite_controller.dart';

class ProductDetailsController extends GetxController {
  final CartController _cart = Get.find();
  final FavoriteController _favorites = Get.find();

  /// بتنقرأ مرة وحدة عند إنشاء الـ Controller
  late final ProductModel product;

  static const int _minQuantity = 1;
  static const int _maxQuantity = 99;

  final List<String> sizes = const ['S', 'M', 'L', 'XL', 'XXL'];

  int quantity = _minQuantity;
  String selectedSize = 'S';

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
  }

  // ---------------- Quantity ----------------
  void increase() {
    if (quantity >= _maxQuantity) return;
    quantity++;
    update(['quantity']);
  }

  void decrease() {
    if (quantity <= _minQuantity) return;
    quantity--;
    update(['quantity']);
  }

  // ---------------- Size ----------------
  void changeSelectedSize(String size) {
    if (selectedSize == size) return;
    selectedSize = size;
    update(['size']);
  }

  // ---------------- Favorite ----------------
  bool get isFavorite => _favorites.isFavorite(product.id);

  void toggleFavorite() {
    _favorites.toggleFavorite(product);
  }

  // ---------------- Cart ----------------
  Future<void> addToCart() async {
  final ok = await _cart.addToCart(
    product: product,
    quantity: quantity,
    size: selectedSize,
  );
  if (!ok) return;

  Get.snackbar(
    AppString.cart,
    '${product.name} ($selectedSize x$quantity)${AppString.addedToCart}',
  );
  Get.toNamed(AppRoutes.myCart);
}
}