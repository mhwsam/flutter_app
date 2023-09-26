// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burobd/utils/auth.dart'; // Import your authentication provider file.

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Welcome to the Home Screen!'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the Home Screen'),

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
          ],
        ),
      ),
    );
  }
}
