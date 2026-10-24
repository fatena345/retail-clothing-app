import 'package:ui_test/model/product/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;
  String size;

  CartItemModel({
    required this.product,
    this.quantity = 1,
    this.size = 'S',
  });

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
    'size': size,
  };

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      size: json['size'] ?? 'S',
    );
  }
}