// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/ProductProvider.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:burobd/utils/auth.dart';

// class CheckoutPage extends StatelessWidget {
//   Future<void> _placeOrder(Map<String, dynamic> orderData) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/place-order');
//     print(apiUrl);

//     try {
//       final response = await http.post(
//         apiUrl,
//         headers: {
//           'Authorization':
//               'Bearer ${authProvider.apiResponse?['access_token']}',
//           'Content-Type': 'application/json', // Set the content type
//         },
//         body: jsonEncode(orderData), // Convert the orderData to JSON
//       );

//       if (response.statusCode == 200) {
//         // Order placed successfully, you can handle the response here
//         final responseData = jsonDecode(response.body);
//         print('Order Response: $responseData');
//       } else {
//         throw Exception(
//             'Failed to place the order. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Access the ProductProvider to retrieve the saved product data
//     final productProvider = Provider.of<ProductProvider>(context);
//     final productData = productProvider.productData;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: productData != null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Product Title: ${productData['title']}'),
//                 Text('Product ID: ${productData['id']}'),
//                 Text('Product SKU: ${productData['sku']}'),
//                 Text('Product UUID: ${productData['uuid']}'),
//                 Text('Photo: ${productData['photo']}'),
//                 Text(
//                     'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}'),
//                 Text(
//                     'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}'),
//                 Text(
//                     'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}'),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Preparing the order data here
//                     final orderData = {
//                       'id': productData['id'],
//                       'photo': productData['photo'],
//                       'cartQuantity': 1,
//                       'price':
//                           productData['companies'][0]['pivot']['price'] ?? 0,
//                       'discount_price': productData['companies'][0]['pivot']
//                               ['discount_price'] ??
//                           0,
//                       'sku': productData['sku'],
//                       'product_tpe': 'CE',
//                       'title': productData['title'],
//                       'uuid': productData['uuid'],
//                       'stock':
//                           productData['companies'][0]['pivot']['stock'] ?? 0,
//                       'vattributes': '',
//                     };

//                     // Call the _placeOrder function to make the POST request
//                     _placeOrder(orderData);
//                   },
//                   child: Text('Place Order'),
//                 ),
//               ],
//             )
//           : const Center(
//               child: Text('Product data is not available.'),
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/ProductProvider.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:burobd/utils/auth.dart';

// class CheckoutPage extends StatelessWidget {

//   Future<void> _placeOrder(BuildContext context, Map<String, dynamic> orderData) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/place-order');
//     print(apiUrl);

//     try {
//       final response = await http.post(
//         apiUrl,
//         headers: {
//           'Authorization':
//               'Bearer ${authProvider.apiResponse?['access_token']}',
//           'Content-Type': 'application/json', // Set the content type
//         },
//         body: jsonEncode(orderData), // Convert the orderData to JSON
//       );

//       if (response.statusCode == 200) {
//         // Order placed successfully, you can handle the response here
//         final responseData = jsonDecode(response.body);
//         print('Order Response: $responseData');
//       } else {
//         throw Exception(
//             'Failed to place the order. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Access the ProductProvider to retrieve the saved product data
//     final productProvider = Provider.of<ProductProvider>(context);
//     final productData = productProvider.productData;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: productData != null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Product Title: ${productData['title']}'),
//                 Text('Product ID: ${productData['id']}'),
//                 Text('Product SKU: ${productData['sku']}'),
//                 Text('Product UUID: ${productData['uuid']}'),
//                 Text('Photo: ${productData['photo']}'),
//                 Text(
//                     'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}'),
//                 Text(
//                     'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}'),
//                 Text(
//                     'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}'),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Preparing the order data here
//                     final orderData = {
//                       'shipping_name': "Ahasan Ullah",
//                       'customer_id': "afsda101",
//                       'nid': 123456,
//                       'id': productData['id'],
//                       'photo': productData['photo'],
//                       'cartQuantity': 1,
//                       'price':
//                           productData['companies'][0]['pivot']['price'] ?? 0,
//                       'discount_price': productData['companies'][0]['pivot']
//                               ['discount_price'] ??
//                           0,
//                       'sku': productData['sku'],
//                       'product_tpe': 'CE',
//                       'title': productData['title'],
//                       'uuid': productData['uuid'],
//                       'stock':
//                           productData['companies'][0]['pivot']['stock'] ?? 0,
//                       'vattributes': '',
//                     };

//                     // Call the _placeOrder function to make the POST request
//                     _placeOrder(context, orderData);
//                   },
//                   child: Text('Place Order'),
//                 ),
//               ],
//             )
//           : const Center(
//               child: Text('Product data is not available.'),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/ProductProvider.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:burobd/utils/auth.dart';

class CheckoutPage extends StatelessWidget {
  Future<void> _placeOrder(
      BuildContext context, Map<String, dynamic> orderData) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/place-order');
    print(apiUrl);

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Authorization':
              'Bearer ${authProvider.apiResponse?['access_token']}',
          'Content-Type': 'application/json', // Set the content type
        },
        body: jsonEncode(orderData), // Convert the orderData to JSON
      );

      if (response.statusCode == 200) {
        // Order placed successfully, you can handle the response here
        final responseData = jsonDecode(response.body);
        print('Order Response: $responseData');
         _showSuccessDialog(context);
      } else {
        throw Exception(
            'Failed to place the order. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Placed Successfully'),
          content: const Text('Your order has been successfully placed.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName('/home'));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the ProductProvider to retrieve the saved product data
    final productProvider = Provider.of<ProductProvider>(context);
    final productData = productProvider.productData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: productData != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Product Title: ${productData['title']}'),
                Text('Product ID: ${productData['id']}'),
                Text('Product SKU: ${productData['sku']}'),
                Text('Product UUID: ${productData['uuid']}'),
                Text('Photo: ${productData['photo']}'),
                Text(
                    'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}'),
                Text(
                    'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}'),
                Text(
                    'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}'),
                ElevatedButton(
                  onPressed: () {
                    // Preparing the order data here
                    // final orderData = {
                    //   'shipping_name': "Ahasan Ullah",
                    //   'customer_id': "afsda101",
                    //   'nid': 123456,
                    //   'id': productData['id'],
                    //   'photo': productData['photo'],
                    //   'cartQuantity': 1,
                    //   'price':
                    //       productData['companies'][0]['pivot']['price'] ?? 0,
                    //   'discount_price': productData['companies'][0]['pivot']
                    //           ['discount_price'] ??
                    //       0,
                    //   'sku': productData['sku'],
                    //   'product_tpe': 'CE',
                    //   'title': productData['title'],
                    //   'uuid': productData['uuid'],
                    //   'stock':
                    //       productData['companies'][0]['pivot']['stock'] ?? 0,
                    //   'vattributes': '',
                    // };
                    final orderData = {
                      "cartTotalAmount": 16738,
                      "cartTotalQuantity": 1,
                      "customer_name": "Ahasan Ullah",
                      "shipping_name": "Ahasan Ullah",
                      "customer_email": "ahasan.ullah@fel.com.bd",
                      "shipping_email": "ahsanullah716@gmail.com",
                      "customer_phone": "0178922912",
                      "customer_address": "Mohammadpur",
                      "customer_city": "Dhaka",
                      "customer_thana": "Mohammadpur",
                      "payment_type": "COD",
                      "order_note": "Test",
                      "customer_id": "afsda101",
                      "cartType": "DEVICE",
                      "center_id": 15,
                      "nid": 123456,
                      "cartItems": [
                        {
                          "id": 275,
                          "photo": "FTL-zkTUaASUrT.webp",
                          "cartQuantity": 1,
                          "price": 23399,
                          "discount_price": 20338,
                          "sku": "SM-E135FIDDBKD",
                          "product_tpe": "CE",
                          "title": "galaxy-f13-464-gb-orange-copper",
                          "uuid": "58bd7bef-3e93-4a3a-83c3-dfc945fd5bd4",
                          "stock": 47,
                          "vattributes": ""
                        }
                      ]
                    };

                    // Call the _placeOrder function to make the POST request
                    _placeOrder(context, orderData);
                  },
                  child: Text('Place Order'),
                ),
              ],
            )
          : const Center(
              child: Text('Product data is not available.'),
            ),
    );
  }
}
