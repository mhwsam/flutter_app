// import 'package:flutter/material.dart';
// import 'package:burobd/utils/api_config.dart';
// import 'package:burobd/utils/auth.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class RefrigeratorPage extends StatefulWidget {
//   @override
//   _RefrigeratorPageState createState() => _RefrigeratorPageState();
// }

// class _RefrigeratorPageState extends State<RefrigeratorPage> {
//   List<String> productTitles = [];

//   Future<void> fetchData() async {
//     final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/category/refrigerator');
//     // final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/category/refrigerator?page=2');

//     try {
//       final response = await http.get(
//         apiUrl,
//         headers: {
//           'Authorization': 'Bearer ${Provider.of<AuthProvider>(context).apiResponse?['access_token']}',
//           // Access apiResponse from AuthProvider and set it in the authorization header
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final products = data['data']['products']['data'] as List<dynamic>;

//         for (var product in products) {
//           final title = product['title'] as String;
//           productTitles.add(title);
//         }

//         setState(() {}); // Trigger a rebuild with the fetched data.
//       } else {
//         throw Exception('Failed to fetch data');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     fetchData(); // Move the fetchData() call to didChangeDependencies
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Refrigerators'),
//       ),
//       body: productTitles.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: productTitles.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(productTitles[index]),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RefrigeratorPage extends StatefulWidget {
  @override
  _RefrigeratorPageState createState() => _RefrigeratorPageState();
}

class _RefrigeratorPageState extends State<RefrigeratorPage> {
  List<String> productTitles = [];
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
          'Authorization': 'Bearer ${authProvider.apiResponse?['access_token']}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final productsData = data['data']['products']['data'];

        if (productsData != null) {
          final products = productsData as List<dynamic>;

          // Clear the productTitles list before adding the new products from page 2.
          if (loadMore) {
            productTitles.clear();
          }

          productTitles.addAll(products.map((product) => product['title'] as String));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Refrigerators'),
      ),
      body: productTitles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: productTitles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(productTitles[index]),
                        ),
                      );
                    },
                  ),
                ),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else if (currentPage <= 2) // Show "Load More" button only if there are more pages to load
                  ElevatedButton(
                    onPressed: () {
                      fetchData(loadMore: true);
                    },
                    child: Text('Load More'),
                  ),
              ],
            ),
            
    );
  }
}


// ahasan.ullah@fel.com.bd
// 01716167744