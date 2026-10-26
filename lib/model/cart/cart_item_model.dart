
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeta/model/product/product_model.dart';

class CartItemModel {
  const CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
  });

  final String id; // "{productId}_{size}"
  final ProductModel product;
  final int quantity;
  final String size;

  static String buildId(String productId, String size) => '${productId}_$size';

  double get total => product.price * quantity;

  /// الـ product مخزن كنسخة بنفس الـ document
  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel(
        id: map['id'] as String,
        product: ProductModel.fromMap({
          ...(map['product'] as Map<String, dynamic>),
          'id': map['productId'] as String,
        }),
        quantity: (map['quantity'] as num?)?.toInt() ?? 1,
        size: map['size'] as String? ?? 'S',
      );

  Map<String, dynamic> toCreateMap() => {
        'productId': product.id,
        'product': product.toUpdateMap(),
        'quantity': quantity,
        'size': size,
        'addedAt': FieldValue.serverTimestamp(),
      };
}