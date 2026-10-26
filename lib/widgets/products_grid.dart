import 'package:flutter/cupertino.dart';
import 'package:geeta/core/constants/app_values.dart';
import 'package:geeta/widgets/product_grid_card.dart';

import '../model/product/product_model.dart';

class ProductsGrid extends StatelessWidget{
  final List<ProductModel> products;

  ProductsGrid({required this.products, });
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     padding: EdgeInsets.zero,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      childAspectRatio: 170 / 276,
        crossAxisSpacing: AppWidth.w14,
      ),
      itemBuilder: (context, index) => ProductGridCard( product: products[index]),
    );
  }

}