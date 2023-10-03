// import 'package:flutter/material.dart';
// import 'package:burobd/widgets/product_card.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class MobileProduct {
//   final String name;
//   final String brand;
//   final double price;
//   final String image;

//   MobileProduct({
//     required this.name,
//     required this.brand,
//     required this.price,
//     required this.image,
//   });
// }

// Future<List<MobileProduct>> fetchMobileProducts() async {
//   // Simulated data retrieval, replace with your actual API call logic.
//   await Future.delayed(Duration(seconds: 1)); // Simulate a 2-second delay.
//   return [
//     MobileProduct(
//       name: 'Mobile Product 1',
//       brand: 'Brand A',
//       price: 499.99,
//       image: 'https://picsum.photos/200/300',
//     ),
//     // Add more products here...
//   ];
// }

// class MobilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text('Mobiles')),
//       ),
//       body: FutureBuilder<List<MobileProduct>>(
//         future: fetchMobileProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Display the DoubleBounce loader animation while waiting for data.
//             return const Center(
//               child: SpinKitDoubleBounce(
//                 color: Colors.blue, // Customize the loader color.
//                 size: 50.0, // Customize the loader size.
//               ),
//             );
//           } else if (snapshot.hasError) {
//             // Handle error if data retrieval fails.
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             // Handle the case where no data is available.
//             return const Center(child: Text('No mobile products available.'));
//           } else {
//             // Data has been successfully fetched, display the products.
//             final mobileProducts = snapshot.data!;
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: mobileProducts.length,
//               itemBuilder: (context, index) {
//                 final product = mobileProducts[index];
//                 return ProductCard(
//                   name: product.name,
//                   image: product.image,
//                   price: product.price,
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:burobd/widgets/product_card.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:burobd/utils/auth.dart'; // Import your authentication provider
import 'package:provider/provider.dart';

class MobileProduct {
  final String name;
  final String brand;
  final double price;
  final String image;

  MobileProduct({
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
  });
}

Future<List<MobileProduct>> fetchMobileProducts(BuildContext context) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  if (!authProvider.isLoggedIn) {
    // Handle unauthenticated state here, e.g., show a login screen
    return [];
  }

  final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/category/mobile');

  final response = await http.get(
    apiUrl,
    headers: {
      'Authorization': 'Bearer ${authProvider.apiResponse?['access_token']}',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("*****");
    print("Mobile theke bolchi mago");

    print(responseData);
    print("**************************");
    print("After Printing Response Data");
    if (responseData.containsKey("data")) {
      print("response data theke ");

      final Map<String, dynamic> data = responseData["data"];
      final List<dynamic> productDataList = data["data"];
      print(data);
      // Parse the JSON data

      // Access the title

      final List<MobileProduct> products = productDataList.map((data) {
        return MobileProduct(
          name: data['name'],
          brand: data['brand'],
          price: data['price'].toDouble(),
          image: data['image'],
        );
      }).toList();
      return products;
    } else {
      throw Exception('API response does not contain a "data" key.');
    }
  } else {
    throw Exception('Failed to load mobile products');
  }
}

class MobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Mobiles')),
      ),
      body: FutureBuilder<List<MobileProduct>>(
        future:
            fetchMobileProducts(context), // Pass the context to the function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display the DoubleBounce loader animation while waiting for data.
            return const Center(
              child: SpinKitDoubleBounce(
                color: Colors.blue, // Customize the loader color.
                size: 50.0, // Customize the loader size.
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error if data retrieval fails.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle the case where no data is available.
            return Center(child: Text('No mobile products available.'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            // Handle the case where no data is available or it's null.
            return Center(child: Text('No mobile products available.'));
          } else {
            // Data has been successfully fetched, display the products.
            final mobileProducts = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: mobileProducts.length,
              itemBuilder: (context, index) {
                final product = mobileProducts[index];
                return ProductCard(
                  name: product.name,
                  image: product.image,
                  price: product.price,
                );
              },
            );
          }
        },
      ),
    );
  }
}
