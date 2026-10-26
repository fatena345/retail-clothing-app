import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geeta/model/product/product_model.dart';
import 'package:geeta/view/home/home_controllers/home_controller.dart';

class ProductSearchController extends GetxController {
  final HomeController _home = Get.find();

  static const Duration _debounceDuration = Duration(milliseconds: 300);

  final searchCtrl = TextEditingController();
  Timer? _debounce;

  String query = '';

  /// النتائج مشتقة من قائمة الهوم، فبتتحدث تلقائياً لو تغيّرت المنتجات
  List<ProductModel> get results {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return _home.products;

    return _home.products.where((p) {
      return p.name.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q);
    }).toList();
  }

  bool get hasQuery => query.trim().isNotEmpty;

  void onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      query = value;
      update();
    });
  }

  void clear() {
    _debounce?.cancel();
    searchCtrl.clear();
    query = '';
    update();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchCtrl.dispose();
    super.onClose();
  }
}