
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/auth.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final apiResponse = authProvider.apiResponse;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               authProvider.logout();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Welcome to the Home Screen'),

//             // Check if the API response is available
//             if (apiResponse != null)
//               Column(
//                 children: [
//                   Text('API Response Data:'),
//                   // Display the API response data here as needed
//                   // Example: Display the user's name
//                   Text('User Name: ${apiResponse['user']['name']}'),
//                    Text('Phone Number: ${apiResponse['user']['phone']}'),
//                   // Add more widgets to display other data from the API response
//                 ],
//               ),
//             // ... (Other widgets you want to display)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/auth.dart';

class HomeScreen extends StatelessWidget {
  final List<CategoryData> categories = [
    CategoryData("Mobile", Icons.phone_android),
    CategoryData("TV", Icons.tv),
    CategoryData("Refrigerator", Icons.kitchen),
    CategoryData("Washing Machine", Icons.local_laundry_service),
    CategoryData("Air Conditioner", Icons.ac_unit),
    CategoryData("Microwave", Icons.microwave),
    CategoryData("Accessories", Icons.phone),
    CategoryData("Small Appliances", Icons.devices_other),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final apiResponse = authProvider.apiResponse;

    return Scaffold(
      appBar: AppBar(
       title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text('Welcome to the Home Screen', style: TextStyle(fontSize: 20)),

              // Search Bar with Icons
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Implement filter functionality here
                      },
                    ),
                  ],
                ),
              ),

              // Check if the API response is available
              if (apiResponse != null)
                Column(
                  children: [
                    Text('API Response Data:'),
                    // Display the API response data here as needed
                    // Example: Display the user's name
                    Text('User Name: ${apiResponse['user']['name']}'),
                    Text('Phone Number: ${apiResponse['user']['phone']}'),
                    // Add more widgets to display other data from the API response
                  ],
                ),
              // ... (Other widgets you want to display)

              // Add the GridView for categories
              Text('All Categories', style: TextStyle(fontSize: 20)),
              GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(category: categories[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryData {
  final String name;
  final IconData icon;

  CategoryData(this.name, this.icon);
}

class CategoryCard extends StatelessWidget {
  final CategoryData category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(category.icon, size: 50),
          SizedBox(height: 10),
          Text(category.name, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
