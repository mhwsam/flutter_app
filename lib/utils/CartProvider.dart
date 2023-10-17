import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:burobd/screens/product_details.dart';
import 'package:burobd/utils/CartProvider.dart';

class Product {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String slug;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.slug,
    this.quantity = 0,
  });
}

class CartProvider with ChangeNotifier {
  List<Product> items = [];

  double get totalPrice {
    return items.fold(
        0, (total, product) => total + (product.price * product.quantity));
  }

  // void addToCart(Product product) {
  //   final existingProduct = items.firstWhere(
  //     (p) => p.id == product.id,
  //     orElse: () => Product(id: -1, name: '', price: 0, quantity: 0, slug: ''), // Provide a default product if not found
  //   );

  //   if (existingProduct.id == -1) {
  //     items.add(product);
  //   } else {
  //     existingProduct.quantity++;
  //   }

  //   notifyListeners();
  // }
  void addToCart(Product product) {
    final existingProductIndex = items.indexWhere((p) => p.id == product.id);

    if (existingProductIndex != -1) {
      // If the product is already in the cart, increment its quantity
      items[existingProductIndex].quantity++;
    } else {
      // If the product is not in the cart, add it with a quantity of 1
      product.quantity = 1;
      items.add(product);
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    items.clear();
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    final existingProduct = items.firstWhere(
      (p) => p.id == product.id,
      orElse: () => Product(
          id: -1,
          name: '',
          price: 0,
          quantity: 0,
          slug: ''), // Provide a default slug if not found
    );

    if (existingProduct.id != -1) {
      existingProduct.quantity = quantity;
      notifyListeners();
    }
  }
}
