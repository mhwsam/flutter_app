import 'package:flutter/material.dart';
import 'package:burobd/utils/api_config.dart';
import 'package:burobd/utils/auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


// class RefrigeratorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Refrigerators'),
//       ),
//       body: Center(
//         child: Text('This is the Refrigerator Page content.'),
//       ),
//     );
//   }
// }

// class RefrigeratorPage extends StatefulWidget {
//   @override
//   _RefrigeratorPageState createState() => _RefrigeratorPageState();
// }

// class _RefrigeratorPageState extends State<RefrigeratorPage> {
//   List<String> productTitles = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     // final apiUrl = '${AppConfig.baseUrl}api/v1/category/refrigerator';
    
//     final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/category/refrigerator');

 

//     try {
//       final response = await http.get(
//        apiUrl,
//        headers: {
//       // 'Authorization': 'Bearer ${AuthProvider.apiResponse?['access_token']}',
//       'Authorization': 'Bearer ${Provider.of<AuthProvider>(context).apiResponse?['access_token']}',
//     },
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

class RefrigeratorPage extends StatefulWidget {
  @override
  _RefrigeratorPageState createState() => _RefrigeratorPageState();
}

class _RefrigeratorPageState extends State<RefrigeratorPage> {
  List<String> productTitles = [];

  Future<void> fetchData() async {
    final apiUrl = Uri.parse('${ApiConfig.baseUrl}api/v1/category/refrigerator');

    try {
      final response = await http.get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer ${Provider.of<AuthProvider>(context).apiResponse?['access_token']}',
          // Access apiResponse from AuthProvider and set it in the authorization header
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = data['data']['products']['data'] as List<dynamic>;

        for (var product in products) {
          final title = product['title'] as String;
          productTitles.add(title);
        }

        setState(() {}); // Trigger a rebuild with the fetched data.
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData(); // Move the fetchData() call to didChangeDependencies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refrigerators'),
      ),
      body: productTitles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(productTitles[index]),
                  ),
                );
              },
            ),
    );
  }
}