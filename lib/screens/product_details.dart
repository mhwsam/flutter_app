import 'package:flutter/material.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:burobd/utils/ProductProvider.dart';
import 'package:burobd/screens/checkout_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String slug;

  ProductDetailsPage({required this.slug});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Map<String, dynamic> productData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final apiUrl =
        Uri.parse('${ApiConfig.baseUrl}api/v1/product/${widget.slug}');
    print(apiUrl);
    try {
      final response = await http.get(
        apiUrl,
        headers: {
          'Authorization':
              'Bearer ${authProvider.apiResponse?['access_token']}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final product = data['product'];

        // Access the ProductProvider and set the product data
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.setProductData(product);

        setState(() {
          productData = product;
        });
      } else {
        throw Exception(
            'Failed to fetch product details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display a single image from the API
            // Image.network(
            //   '${ApiConfig.baseUrl}uploads/${productData['photo']}',
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            Image.network(
              "${ApiConfig.baseUrl}api/v1/product/${productData['photo']}",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                productData['title'] ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Implement  "Buy Now" functionality here
                  //     Navigator.of(context).pushNamed('/checkout');
                  //   },
                  //   child: const Text('Buy Now'),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      if (productData['companies'][0]['pivot']['stock'] == 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Out of Stock'),
                              content: const Text(
                                  'Sorry, this product is currently out of stock.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Implement "Buy Now" functionality here, e.g., navigate to the checkout page.
                        Navigator.of(context).pushNamed('/checkout');
                      }
                    },
                    child: const Text('Buy Now'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                border: TableBorder.all(),
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Text('Specifications',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      TableCell(
                        child: Text('Value',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  for (final spec in productData['specifications_json'])
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              spec['key'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              spec['value'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
