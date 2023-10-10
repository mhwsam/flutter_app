import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  Map<String, dynamic>? _productData;

  Map<String, dynamic>? get productData => _productData;

  void setProductData(Map<String, dynamic> data) {
    _productData = data;
    notifyListeners();
  }
}

