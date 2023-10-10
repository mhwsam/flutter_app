import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/ProductProvider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the ProductProvider to retrieve the saved product data
    final productProvider = Provider.of<ProductProvider>(context);
    final productData = productProvider.productData;

    // Print the productData to the console
    print("**********");
    print('Product Data: $productData');

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: productData != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Product Title: ${productData['title']}'),
                Text('Product Price: ${productData['price']}'),
                // Add more widgets to display product information and implement checkout logic
              ],
            )
          : Center(
              child: Text('Product data is not available.'),
            ),
    );
  }
}
