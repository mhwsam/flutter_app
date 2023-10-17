// import 'package:flutter/material.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:burobd/utils/auth.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:burobd/screens/product_details.dart';

// class RefrigeratorPage extends StatefulWidget {
//   const RefrigeratorPage({super.key});

//   @override
//   _RefrigeratorPageState createState() => _RefrigeratorPageState();
// }

// class _RefrigeratorPageState extends State<RefrigeratorPage> {
//   List<Map<String, dynamic>> productsInfo = [];
//   int currentPage = 1;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData({bool loadMore = false}) async {
//     if (isLoading) return;

//     setState(() {
//       isLoading = true;
//     });

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl = Uri.parse(
//         '${ApiConfig.baseUrl}api/v1/category/refrigerator?page=$currentPage');

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
//         final productsData = data['data']['products']['data'];

// // Inside the try block, after parsing productsData
//         if (productsData != null) {
//           final products = productsData as List<dynamic>;

//           // Extract and store additional information for each product
//           for (var product in products) {
//             final pivotData = product['companies'][0]['pivot'];
//             final productInfo = {
//               'title': product['title'] as String,
//               'photo': product['photo'] as String,
//               'regular_price': pivotData['price'],
//               'discount_price': pivotData['discount_price'],
//               'stock': pivotData['stock'],
//               'slug': product['slug'] as String,
//             };
//             productsInfo.add(productInfo);
//             // print(productInfo['slug']);
//           }
//         } else {
//           throw Exception('No products data in API response');
//         }

//         final nextPage = data['data']['products']['next_page_url'];

//         if (nextPage != null) {
//           currentPage++;
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch data. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Refrigerators'),
//       ),
//       body: productsInfo.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: productsInfo.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final productInfo = productsInfo[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text(productInfo['title']),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Regular Price: ${productInfo['regular_price']}'),
//                               Text(
//                                   'Discount Price: ${productInfo['discount_price']}'),
//                               Text('Stock: ${productInfo['stock']}'),
//                             ],
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons
//                                   .shopping_cart), // Add your desired icon here
//                               ElevatedButton(
//                                 onPressed: () {
//                                   // Implement your "Add to Cart" functionality here
//                                   // You can add the selected product to the cart or perform any other action.
//                                 },
//                                 child: const Text('Add to Cart'),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             // Navigate to the product details page with the selected product's name
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailsPage(
//                                   // productName: productInfo[
//                                   //     'title'], // Pass the selected product's title
//                                   // regularPrice: productInfo[
//                                   //     'regular_price'], // Pass the regular price
//                                   // discountPrice: productInfo[
//                                   //     'discount_price'], // Pass the discount price
//                                   // stock: productInfo['stock'], // Pass the stock
//                                   slug: productInfo['slug'], // Pass the slug
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 if (isLoading)
//                   const Center(child: CircularProgressIndicator())
//                 else if (currentPage <=
//                     2) // Show "Load More" button only if there are more pages to load
//                   ElevatedButton(
//                     onPressed: () {
//                       fetchData(loadMore: true);
//                     },
//                     child: const Text('Load More'),
//                   ),
//               ],
//             ),
//     );
//   }
// }

// // ahasan.ullah@fel.com.bd
// // 01716167744

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:burobd/utils/auth.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:burobd/screens/product_details.dart';
// import 'package:burobd/utils/CartProvider.dart';

// class RefrigeratorPage extends StatefulWidget {
//   const RefrigeratorPage({Key? key});

//   @override
//   _RefrigeratorPageState createState() => _RefrigeratorPageState();
// }

// class _RefrigeratorPageState extends State<RefrigeratorPage> {
//   List<Map<String, dynamic>> productsInfo = [];
//   int currentPage = 1;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData({bool loadMore = false}) async {
//     if (isLoading) return;

//     setState(() {
//       isLoading = true;
//     });

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl = Uri.parse(
//         '${ApiConfig.baseUrl}api/v1/category/refrigerator?page=$currentPage');

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
//         final productsData = data['data']['products']['data'];

//         if (productsData != null) {
//           final products = productsData as List<dynamic>;

//           for (var product in products) {
//             final pivotData = product['companies'][0]['pivot'];
//             final productInfo = {
//               'id': product['id'],
//               'title': product['title'] as String,
//               'photo': product['photo'] as String,
//               'regular_price': pivotData['price'],
//               'discount_price': pivotData['discount_price'],
//               'stock': pivotData['stock'],
//               'slug': product['slug'] as String,
//             };
//             productsInfo.add(productInfo);
//           }
//         } else {
//           throw Exception('No products data in API response');
//         }

//         final nextPage = data['data']['products']['next_page_url'];

//         if (nextPage != null) {
//           currentPage++;
//         }
//       } else {
//         throw Exception(
//             'Failed to fetch data. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Refrigerators'),
//       ),
//       body: productsInfo.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: productsInfo.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final productInfo = productsInfo[index];
//                       return Card(
//                         child: ListTile(
//                           title: Text(productInfo['title']),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                   'Regular Price: ${productInfo['regular_price']}'),
//                               Text(
//                                   'Discount Price: ${productInfo['discount_price']}'),
//                               Text('Stock: ${productInfo['stock']}'),
//                             ],
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(Icons.shopping_cart),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   // Add the selected product to the cart
//                                   final product = Product(
//                                     id: productInfo['id'],
//                                     name: productInfo['title'],
//                                     price: productInfo['discount_price'],
//                                     slug: productInfo['slug'], // Include the 'slug' property
//                                   );
//                                   cart.addToCart(product);
//                                 },
//                                 child: const Text('Add to Cart'),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailsPage(
//                                   slug: productInfo['slug'],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 if (isLoading)
//                   const Center(child: CircularProgressIndicator())
//                 else if (currentPage <= 2)
//                   ElevatedButton(
//                     onPressed: () {
//                       fetchData(loadMore: true);
//                     },
//                     child: const Text('Load More'),
//                   ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/cart');
//                   },
//                   child: const Text('Go to Cart'),
//                 )
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:burobd/screens/product_details.dart';
import 'package:burobd/utils/CartProvider.dart';

class RefrigeratorPage extends StatefulWidget {
  const RefrigeratorPage({Key? key});

  @override
  _RefrigeratorPageState createState() => _RefrigeratorPageState();
}

class _RefrigeratorPageState extends State<RefrigeratorPage> {
  List<Map<String, dynamic>> productsInfo = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData({bool loadMore = false}) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final apiUrl = Uri.parse(
        '${ApiConfig.baseUrl}api/v1/category/refrigerator?page=$currentPage');

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
        final productsData = data['data']['products']['data'];

        if (productsData != null) {
          final products = productsData as List<dynamic>;

          for (var product in products) {
            final pivotData = product['companies'][0]['pivot'];
            final productInfo = {
              'id': product['id'],
              'title': product['title'] as String,
              'photo': product['photo'] as String,
              'regular_price': pivotData['price'],
              'discount_price': pivotData['discount_price'],
              'stock': pivotData['stock'],
              'slug': product['slug'] as String,
            };
            productsInfo.add(productInfo);
          }
        } else {
          throw Exception('No products data in API response');
        }

        final nextPage = data['data']['products']['next_page_url'];

        if (nextPage != null) {
          currentPage++;
        }
      } else {
        throw Exception(
            'Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Refrigerators'),
      ),
      body: productsInfo.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: productsInfo.length,
                    itemBuilder: (BuildContext context, int index) {
                      final productInfo = productsInfo[index];
                      return Card(
                        child: ListTile(
                          title: Text(productInfo['title']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Regular Price: ${productInfo['regular_price']}'),
                              Text(
                                  'Discount Price: ${productInfo['discount_price']}'),
                              Text('Stock: ${productInfo['stock']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.shopping_cart),
                              
                              ElevatedButton(
                                onPressed: () {
                                  if (productInfo['stock'] == 0) {
                                    // Show a SnackBar with "No Stock Available"
                                    const noStockSnackBar =  SnackBar(
                                      content: Text('No Stock Available'),
                                      duration:  Duration(seconds: 1),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(noStockSnackBar);
                                  } else {
                                    // Add the selected product to the cart
                                    final product = Product(
                                      id: productInfo['id'],
                                      name: productInfo['title'],
                                      price: productInfo['discount_price'],
                                      slug: productInfo[
                                          'slug'], // Include the 'slug' property
                                    );
                                    // Use setState to trigger a UI update
                                    setState(() {
                                      cart.addToCart(product);
                                    });
                                    // Show a SnackBar message for adding to the cart
                                    const snackBar = SnackBar(
                                      content: Text('Item added to the Cart'),
                                      duration: Duration(seconds: 2),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: const Text('Add to Cart'),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  slug: productInfo['slug'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isLoading)
                      const CircularProgressIndicator()
                    else if (currentPage <= 2)
                      ElevatedButton(
                        onPressed: () {
                          fetchData(loadMore: true);
                        },
                        child: const Text('Load More'),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: const Text('Go to Cart'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
