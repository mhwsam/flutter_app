// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/ProductProvider.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:burobd/utils/auth.dart';

// class CheckoutPage extends StatelessWidget {
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
//                 // Text('Product Price: ${productData['price']}'),
//                 Text(
//                   'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}',
//                 ),
//                 Text(
//                   'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}',
//                 ),

//                 Text(
//                   'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}',
//                 ),
//                 // Add more widgets to display product information and implement checkout logic
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


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/ProductProvider.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:burobd/utils/auth.dart';

class CheckoutPage extends StatelessWidget {



  
  Future<void> _placeOrder(BuildContext context, Map<String, dynamic> orderData) async {
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
      } else {
        throw Exception(
            'Failed to place the order. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
                    final orderData = {
                      'id': productData['id'],
                      'photo': productData['photo'],
                      'cartQuantity': 1,
                      'price':
                          productData['companies'][0]['pivot']['price'] ?? 0,
                      'discount_price': productData['companies'][0]['pivot']
                              ['discount_price'] ??
                          0,
                      'sku': productData['sku'],
                      'product_tpe': 'CE',
                      'title': productData['title'],
                      'uuid': productData['uuid'],
                      'stock':
                          productData['companies'][0]['pivot']['stock'] ?? 0,
                      'vattributes': '',
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
