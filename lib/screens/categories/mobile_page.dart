// // import 'package:flutter/material.dart';

// // class MobilePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Mobiles'),
// //       ),
// //       body: Center(
// //         child: Text('This is the Mobile Page content.'),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:burobd/widgets/product_card.dart';

// // Step 1: Create a model for Mobile Products
// class MobileProduct {
//   final String name;
//   final String brand;
//   final double price;

//   MobileProduct({
//     required this.name,
//     required this.brand,
//     required this.price,
//   });
// }

// // Step 2: Fetch Mobile Product Data (Replace with actual data retrieval logic)
// List<MobileProduct> fetchMobileProducts() {
//   // Simulated data, you should replace this with actual data retrieval logic.
//   return [
//     MobileProduct(name: 'Mobile Product 1', brand: 'Brand A', price: 499.99),
//     MobileProduct(name: 'Mobile Product 2', brand: 'Brand B', price: 399.99),
//     MobileProduct(name: 'Mobile Product 3', brand: 'Brand C', price: 599.99),
//   ];
// }

// class MobilePage extends StatelessWidget {
//   final List<MobileProduct> mobileProducts = fetchMobileProducts();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mobiles'),
//       ),
//       body: ListView.builder(
//         itemCount: mobileProducts.length,
//         itemBuilder: (context, index) {
//           final product = mobileProducts[index];
//           return ListTile(
//             title: Text(product.name),
//             subtitle: Text('${product.brand} - \$${product.price.toStringAsFixed(2)}'),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:burobd/widgets/product_card.dart';

// Step 1: Create a model for Mobile Products
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

// Step 2: Fetch Mobile Product Data (Replace with actual data retrieval logic)
List<MobileProduct> fetchMobileProducts() {
  // Simulated data, you should replace this with actual data retrieval logic.
  return [
    MobileProduct(
      name: 'Mobile Product 1',
      brand: 'Brand A',
      price: 499.99,
      image: 'https://picsum.photos/200/300',
    ),
    MobileProduct(
      name: 'Mobile Product 2',
      brand: 'Brand B',
      price: 399.99,
      image: 'https://picsum.photos/200/300',
    ),
    MobileProduct(
      name: 'Mobile Product 3',
      brand: 'Brand C',
      price: 599.99,
      image: 'https://picsum.photos/200/300',
    ),
  ];
}

class MobilePage extends StatelessWidget {
  final List<MobileProduct> mobileProducts = fetchMobileProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Mobiles')),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display three products per row
          childAspectRatio: 0.7, // Adjust as needed for card width
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
      ),
    );
  }
}
