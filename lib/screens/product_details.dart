import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productName;
  final int regularPrice;
  final int discountPrice;
  final int stock;

  ProductDetailsPage({
    required this.productName,
    required this.regularPrice,
    required this.discountPrice,
    required this.stock,
  });

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product Name: $productName'),
            Text('Regular Price: $regularPrice'),
            Text('Discount Price: $discountPrice'),
            Text('Stock: $stock'),
            // Add more product details here
          ],
        ),
      ),
    );
  }
}