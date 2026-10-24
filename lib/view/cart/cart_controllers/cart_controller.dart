import 'package:get/get.dart';
import 'package:ui_test/model/product/product_model.dart';

import '../cart_models/cart_model.dart';

class CartController extends GetxController {
  List<CartItemModel> cartItems = [];

  // حساب المجموع الكلي للمنتجات داخل السلة ديناميكياً
  num get totalCost {
    return cartItems.fold(
      0,
          (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  // إضافة منتج إلى السلة أو زيادة كميته إذا كان موجوداً بنفس المقاس
  void addToCart({
    required ProductModel product,
    int quantity = 1,
    String size = 'S',
  }) {
    final existingIndex = cartItems.indexWhere(
          (item) => item.product.id == product.id && item.size == size,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity += quantity;
    } else {
      cartItems.add(
        CartItemModel(
          product: product,
          quantity: quantity,
          size: size,
        ),
      );
    }
    update();
  }

  // زيادة كمية عنصر محدد
  void incrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity++;
      update();
    }
  }

  // نقصان كمية عنصر محدد
  void decrementQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        removeFromCart(index);
      }
      update();
    }
  }

  // حذف عنصر من السلة
  void removeFromCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      update();
    }
  }

  // إفراغ السلة بعد إتمام الطلب
  void clearCart() {
    cartItems.clear();
    update();
  }
}