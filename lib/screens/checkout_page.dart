// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/ProductProvider.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:burobd/utils/auth.dart';
// import 'package:flutter/services.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   String? selectedCenterId;
//   final TextEditingController shippingNameController = TextEditingController();
//   final TextEditingController customerAddressController = TextEditingController();
//   final TextEditingController customerIdController = TextEditingController();
//   final TextEditingController nidController = TextEditingController();

//   Future<void> _placeOrder(
//       BuildContext context, Map<String, dynamic> orderData) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/place-order');

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
//         _showSuccessDialog(context);
//       } else {
//         throw Exception(
//             'Failed to place the order. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Order Placed Successfully'),
//           content: const Text('Your order has been successfully placed.'),
//           actions: [
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).popUntil(ModalRoute.withName('/home'));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final productData = productProvider.productData;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkout'),
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
//                 TextField(
//                   controller: shippingNameController,
//                   decoration: const InputDecoration(labelText: 'Shipping Name'),
//                 ),
//                 TextField(
//                   controller: customerAddressController,
//                   decoration: const InputDecoration(labelText: 'Customer Address'),
//                 ),
//                 TextField(
//                   controller: customerIdController,
//                   decoration: const InputDecoration(labelText: 'Customer ID'),
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: selectedCenterId,
//                   items: const [
//                     DropdownMenuItem(
//                       value: "2001-IT Office",
//                       child: Text("2001-IT Office"),
//                     ),
//                     DropdownMenuItem(
//                       value: "1008-Gulshan",
//                       child: Text("1008-Gulshan"),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCenterId = value;
//                     });
//                   },
//                   hint: const Text('Select Center'),
//                 ),
//                 TextField(
//                   controller: nidController,
//                   decoration: const InputDecoration(labelText: 'NID'),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     final orderData = {
//                       "cartTotalAmount": 16738,
//                       "cartTotalQuantity": 1,
//                       "customer_name": "Ahasan Ullah",
//                       "shipping_name": shippingNameController.text,
//                       "customer_email": "ahasan.ullah@fel.com.bd",
//                       "shipping_email": "ahsanullah716@gmail.com",
//                       "customer_phone": "0178922912",
//                       "customer_address": customerAddressController.text,
//                       "customer_city": "Dhaka",
//                       "customer_thana": "Mohammadpur",
//                       "payment_type": "COD",
//                       "order_note": "Test",
//                       "customer_id": customerIdController.text,
//                       "cartType": "DEVICE",
//                       "center_id": selectedCenterId,
//                       "nid": int.parse(nidController.text),
//                       "cartItems": [
//                         {
//                           "id": 275,
//                           "photo": "FTL-zkTUaASUrT.webp",
//                           "cartQuantity": 1,
//                           "price": 23399,
//                           "discount_price": 20338,
//                           "sku": "SM-E135FIDDBKD",
//                           "product_tpe": "CE",
//                           "title": "galaxy-f13-464-gb-orange-copper",
//                           "uuid": "58bd7bef-3e93-4a3a-83c3-dfc945fd5bd4",
//                           "stock": 47,
//                           "vattributes": ""
//                         }
//                       ],
//                     };

//                     _placeOrder(context, orderData);
//                   },
//                   child: const Text('Place Order'),
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
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/ProductProvider.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:burobd/utils/auth.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? selectedCenterId;
//   final TextEditingController shippingNameController = TextEditingController();
//   final TextEditingController customerAddressController = TextEditingController();
//   final TextEditingController customerIdController = TextEditingController();
//   final TextEditingController nidController = TextEditingController();

//   Future<void> _placeOrder(
//       BuildContext context, Map<String, dynamic> orderData) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/place-order');

//     try {
//       final response = await http.post(
//         apiUrl,
//         headers: {
//           'Authorization':
//               'Bearer ${authProvider.apiResponse?['access_token']}',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(orderData),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         print('Order Response: $responseData');
//         _showSuccessDialog(context);
//       } else {
//         throw Exception(
//             'Failed to place the order. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Order Placed Successfully'),
//           content: const Text('Your order has been successfully placed.'),
//           actions: [
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).popUntil(ModalRoute.withName('/home'));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final productData = productProvider.productData;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkout'),
//       ),
//       body: productData != null
//           ? Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Product Title: ${productData['title']}'),
//                   Text('Product ID: ${productData['id']}'),
//                   Text('Product SKU: ${productData['sku']}'),
//                   Text('Product UUID: ${productData['uuid']}'),
//                   Text('Photo: ${productData['photo']}'),
//                   Text(
//                       'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}'),
//                   Text(
//                       'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}'),
//                   Text(
//                       'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}'),

//                   TextFormField(
//                     controller: shippingNameController,
//                     decoration: const InputDecoration(labelText: 'Shipping Name'),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Shipping Name is required';
//                       }
//                       return null;
//                     },
//                   ),

//                   TextFormField(
//                     controller: customerAddressController,
//                     decoration: const InputDecoration(labelText: 'Customer Address'),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Customer Address is required';
//                       }
//                       return null;
//                     },
//                   ),

//                   TextFormField(
//                     controller: customerIdController,
//                     decoration: const InputDecoration(labelText: 'Customer ID'),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Customer ID is required';
//                       }
//                       return null;
//                     },
//                   ),

//                   DropdownButtonFormField<String>(
//                     value: selectedCenterId,
//                     items: const [
//                       DropdownMenuItem(
//                         value: "2001-IT Office",
//                         child: Text("2001-IT Office"),
//                       ),
//                       DropdownMenuItem(
//                         value: "1008-Gulshan",
//                         child: Text("1008-Gulshan"),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCenterId = value;
//                       });
//                     },
//                     hint: const Text('Select Center'),
//                   ),

//                   TextFormField(
//                     controller: nidController,
//                     decoration: const InputDecoration(labelText: 'NID'),
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'NID is required';
//                       }
//                       return null;
//                     },
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         final orderData = {
//                           "cartTotalAmount": 16738,
//                           "cartTotalQuantity": 1,
//                           "customer_name": "Ahasan Ullah",
//                           "shipping_name": shippingNameController.text,
//                           "customer_email": "ahasan.ullah@fel.com.bd",
//                           "shipping_email": "ahsanullah716@gmail.com",
//                           "customer_phone": "0178922912",
//                           "customer_address": customerAddressController.text,
//                           "customer_city": "Dhaka",
//                           "customer_thana": "Mohammadpur",
//                           "payment_type": "COD",
//                           "order_note": "Test",
//                           "customer_id": customerIdController.text,
//                           "cartType": "DEVICE",
//                           "center_id": selectedCenterId,
//                           "nid": int.parse(nidController.text),
//                           "cartItems": [
//                             {
//                               "id": 275,
//                               "photo": "FTL-zkTUaASUrT.webp",
//                               "cartQuantity": 1,
//                               "price": 23399,
//                               "discount_price": 20338,
//                               "sku": "SM-E135FIDDBKD",
//                               "product_tpe": "CE",
//                               "title": "galaxy-f13-464-gb-orange-copper",
//                               "uuid": "58bd7bef-3e93-4a3a-83c3-dfc945fd5bd4",
//                               "stock": 47,
//                               "vattributes": ""
//                             }
//                           ],
//                         };

//                         _placeOrder(context, orderData);
//                       }
//                     },
//                     child: const Text('Place Order'),
//                   ),
//                 ],
//               ),
//             )
//           : const Center(
//               child: Text('Product data is not available.'),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/ProductProvider.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:burobd/utils/auth.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Fetch center data when the widget is initialized
    fetchCenterList(context).then((map) {
      setState(() {
        centerMap = map;
      });
    });
  }

  int? selectedCenterId;
  final TextEditingController shippingNameController = TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController nidController = TextEditingController();
  Map<int, String> centerMap = {}; // Variable to store center data
  Future<void> _placeOrder(
      BuildContext context, Map<String, dynamic> orderData) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/place-order');

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Authorization':
              'Bearer ${authProvider.apiResponse?['access_token']}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Check the 'status' field in the response JSON
        if (responseData['status'] == true) {
          // Order placed successfully
          // Access other data if needed
          final data = responseData['data'];
          print('Order Response: $data');
          _showSuccessDialog(context);
        } else {
          // Handle the case where the 'status' is false
          final message = responseData['message'];
          print('Failed to place the order: $message');
          print("---------------------------");
        }
      } else {
        throw Exception(
            'Failed to place the order. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<int, String>> fetchCenterList(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/centers');
    final response = await http.get(
      apiUrl,
      headers: {
        'Authorization': 'Bearer ${authProvider.apiResponse?['access_token']}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> centerData = data['centerDetails']['data'];
      final Map<int, String> centerMap = {};

      centerData.forEach((center) {
        final int id = center['id'];
        final String name = center['center_name'];
        centerMap[id] = name;
      });

      return centerMap;
    } else {
      throw Exception(
          'Failed to fetch center list. Status Code: ${response.statusCode}');
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
              child: const Text('OK'),
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
    final productProvider = Provider.of<ProductProvider>(context);
    final productData = productProvider.productData;
    String? selectedCenterName;
    int? selectedCenterId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: productData != null
          ? Form(
              key: _formKey,
              child: Column(
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
                  TextFormField(
                    controller: shippingNameController,
                    decoration:
                        const InputDecoration(labelText: 'Shipping Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Shipping Name is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: customerAddressController,
                    decoration:
                        const InputDecoration(labelText: 'Customer Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Customer Address is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: customerIdController,
                    decoration: const InputDecoration(labelText: 'Customer ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Customer ID is required';
                      }
                      return null;
                    },
                  ),
                  // DropdownButtonFormField<String>(
                  //   value: selectedCenterId,
                  //   items: const [
                  //     DropdownMenuItem(
                  //       value: "2001-IT Office",
                  //       child: Text("2001-IT Office"),
                  //     ),
                  //     DropdownMenuItem(
                  //       value: "1008-Gulshan",
                  //       child: Text("1008-Gulshan"),
                  //     ),
                  //   ],
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedCenterId = value;
                  //     });
                  //   },
                  //   hint: const Text('Select Center'),
                  // ),
                  DropdownButtonFormField<int>(
                    value: selectedCenterId,
                    items: centerMap.keys.map((id) {
                      return DropdownMenuItem<int>(
                        value: id,
                        child: Text(centerMap[id]!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCenterId = value;
                      });
                    },
                    hint: const Text('Select Center'),
                  ),

                  TextFormField(
                    controller: nidController,
                    decoration: const InputDecoration(labelText: 'NID'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'NID is required';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final orderData = {
                          "cartTotalAmount": 16738,
                          "cartTotalQuantity": 1,
                          "customer_name": "Ahasan Ullah",
                          "shipping_name": shippingNameController.text,
                          "customer_email": "ahasan.ullah@fel.com.bd",
                          "shipping_email": "ahsanullah716@gmail.com",
                          "customer_phone": "0178922912",
                          "customer_address": customerAddressController.text,
                          "customer_city": "Dhaka",
                          "customer_thana": "Mohammadpur",
                          "payment_type": "COD",
                          "order_note": "Test",
                          "customer_id": customerIdController.text,
                          "cartType": "DEVICE",
                          // "center_id": selectedCenterId,
                          "center_id":  selectedCenterId,
                          "nid": int.parse(nidController.text),
                          "cartItems": [
                            {
                              // "id": 275,
                              "id": productData['id'],
                              // "photo": "FTL-zkTUaASUrT.webp",
                              "photo": productData['photo'],
                              "cartQuantity": 1,
                              // "price": 23399,
                              "price": productData['companies'][0]['pivot']
                                  ['price'],
                              // "discount_price": 20338,
                              "discount_price": productData['companies'][0]
                                  ['pivot']['discount_price'],

                              //"sku": "SM-E135FIDDBKD",
                              "sku": productData['sku'],
                              "product_tpe": "DEVICE",
                              // "title": "galaxy-f13-464-gb-orange-copper",
                              "title": productData['title'],
                              // "uuid": "58bd7bef-3e93-4a3a-83c3-dfc945fd5bd4",
                              "uuid": productData['uuid'],
                              "stock": productData['companies'][0]['pivot']
                                  ['stock'],

                              "vattributes": "",
                            }
                          ],
                        };

                        _placeOrder(context, orderData);
                      }
                    },
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('Product data is not available.'),
            ),
    );
  }
}
