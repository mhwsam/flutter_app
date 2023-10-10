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
    // print("**********");
    // print('Product Data: $productData');

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
                // Text('Product Price: ${productData['price']}'),
                Text(
                  'Price: ${productData['companies'][0]['pivot']['price'] ?? ''}',
                ),
                Text(
                  'Discount Price: ${productData['companies'][0]['pivot']['discount_price'] ?? ''}',
                ),

                Text(
                  'Stock: ${productData['companies'][0]['pivot']['stock'] ?? ''}',
                ),
                // Add more widgets to display product information and implement checkout logic
              ],
            )
          : const Center(
              child: Text('Product data is not available.'),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/ProductProvider.dart';

// class CheckoutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Access the ProductProvider to retrieve the saved product data
//     final productProvider = Provider.of<ProductProvider>(context);
//     final productData = productProvider.productData;

//     // Extract the product object from the productData
//     final product = productData['product'];

//     // Extract the product information from the product object
//     final id = product['id'];
//     final photo = product['photo'];
//     final price = product['companies'][0]['pivot']['price'];
//     final discountPrice = product['companies'][0]['pivot']['discount_price'];
//     final sku = product['sku'];
//     final title = product['title'];
//     final uuid = product['uuid'];
//     final stock = product['companies'][0]['pivot']['stock'];

//     // Display the product information on the screen
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: product != null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Product Title: $title'),
//                 Text('Product Price: $price'),
//                 Text('Product Discount Price: $discountPrice'),
//                 Text('Product SKU: $sku'),
//                 Text('Product ID: $id'),
//                 Text('Product UUID: $uuid'),
//                 Text('Product Stock: $stock'),
//                 // Add more widgets to display product information and implement checkout logic
//               ],
//             )
//           : Center(
//               child: Text('Product data is not available.'),
//             ),
//     );
//   }
// }
