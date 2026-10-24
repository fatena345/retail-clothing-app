import '../category/category_model.dart';

class ProductModel {
  final int id;
  final String title;
  final String slug;
  final num price;
  final String description;
  final CategoryModel category;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> cleanImages = [];
    if (json['images'] != null) {
      for (var img in json['images']) {
        String s = img.toString().replaceAll(RegExp(r'[\[\]\\"]'), '').trim();
        if (s.startsWith('http')) {
          cleanImages.add(s);
        }
      }
    }
    if (cleanImages.isEmpty) {
      cleanImages.add("https://via.placeholder.com/300");
    }

    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : CategoryModel(id: 0, name: 'General', slug: 'general', image: ''),
      images: cleanImages,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'price': price,
    'description': description,
    'category': category.toJson(),
    'images': images,
  };
}