import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  const ProductModel({
    this.id = '',
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.imageUrl,
    this.createdAt,
  });

  final String id; // فاضي عند الإنشاء، Firestore بيولّده
  final String name;
  final double price;
  final String description;
  final int categoryId;
  final String imageUrl;
  final DateTime? createdAt;

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'] as String,
        name: map['name'] as String? ?? '',
        price: (map['price'] as num?)?.toDouble() ?? 0,
        description: map['description'] as String? ?? '',
        categoryId: (map['categoryId'] as num?)?.toInt() ?? 1,
        imageUrl: map['imageUrl'] as String? ?? '',
        createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      );

  Map<String, dynamic> toCreateMap() => {
        'name': name,
        'price': price,
        'description': description,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> toUpdateMap() => {
        'name': name,
        'price': price,
        'description': description,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
      };
}