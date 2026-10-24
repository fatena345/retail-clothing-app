import 'package:get/get.dart';

class ProductDetailsController extends GetxController{
  int quantity = 1;

  void increase()
  {
    quantity++;
    update();
  }

  void decrease()
  {
    quantity--;
    update();
  }

  String selectedSize = 'S';
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  void changeSelectedSizeColor({required String size})
  {
    selectedSize = size;
    update();
  }
}