// import 'package:flutter/material.dart';

// class ProductDetailsPage extends StatelessWidget {
//   final String productName;
//   final int regularPrice;
//   final int discountPrice;
//   final int stock;
//   final String slug;

//   ProductDetailsPage({
//     required this.productName,
//     required this.regularPrice,
//     required this.discountPrice,
//     required this.stock,
//     required this.slug,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Product Name: $productName'),
//             Text('Regular Price: $regularPrice'),
//             Text('Discount Price: $discountPrice'),
//             Text('Stock: $stock'),
//             Text('Slug: $slug'),

//             // Add more product details here
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:burobd/utils/auth.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// import 'package:carousel_slider/carousel_slider.dart'; // Import the CarouselSlider package

// class ProductDetailsPage extends StatefulWidget {
//   final String slug;

//   ProductDetailsPage({required this.slug});

//   @override
//   _ProductDetailsPageState createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   Map<String, dynamic> productData = {};

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl =
//         Uri.parse('${ApiConfig.baseUrl}api/v1/product/${widget.slug}');
//     print(apiUrl);
//     try {
//       final response = await http.get(
//         apiUrl,
//         headers: {
//           'Authorization':
//               'Bearer ${authProvider.apiResponse?['access_token']}',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final product = data['product'];

//         setState(() {
//           productData = product;
//         });
//       } else {
//         throw Exception(
//             'Failed to fetch product details. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<String> imageUrls = productData['galleries'] != null
//         ? List<String>.from(
//             productData['galleries'].map((gallery) => gallery['image']))
//         : [];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CarouselSlider(
//               items: imageUrls.map((imageUrl) {
//                 return Image.network(imageUrl, fit: BoxFit.cover);
//               }).toList(),
//               options: CarouselOptions(
//                 height: 200,
//                 viewportFraction: 1.0,
//                 enlargeCenterPage: false,
//                 autoPlay: true,
//                 aspectRatio: 16 / 9,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     productData['title'] ?? '',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Implement your "Buy Now" functionality here
//                     },
//                     child: const Text('Buy Now'),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                       'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}'),
//                   Text(
//                       'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}'),
//                   Text(
//                       'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}'),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Table(
//                 border: TableBorder.all(),
//                 children: [
//                   const TableRow(
//                     children: [
//                       TableCell(
//                         child: Text('Specifications',
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   ),
//                   TableRow(
//                     children: [
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(productData['specifications'] ?? ''),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
            Image.network(
              '${ApiConfig.baseUrl}uploads/${productData['photo']}',
              fit: BoxFit.cover,
              width: double.infinity,
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
                  ElevatedButton(
                    onPressed: () {
                      // Implement  "Buy Now" functionality here
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
                        child: Center(
                          child: Text('Specifications',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
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
