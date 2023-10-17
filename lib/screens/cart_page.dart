import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:burobd/screens/product_details.dart';
import 'package:burobd/utils/CartProvider.dart';
import 'package:burobd/screens/checkout_page.dart'; // Import the checkout page

class CartPage extends StatelessWidget {
  final productInfo = {
    'slug': 'my-product-slug', // Define the 'productInfo' variable
  };

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: ৳ ${(product.price * product.quantity).toStringAsFixed(2)}'),
                            Text('Quantity: ${product.quantity}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                cart.removeFromCart(product); // Remove the product from the cart
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to the product details page if desired
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(slug: productInfo['slug'] ?? ''), // Provide the 'slug' here
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cart.clearCart(); // Clear the cart when the button is pressed
                      },
                      child: const Text('Clear Cart'),
                    ),
                    ElevatedButton(  // Add the "Buy Now" button
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout'); // Navigate to the checkout page
                      },
                      child: const Text('Buy Now'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

