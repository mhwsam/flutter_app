// import 'package:flutter/material.dart';

// class SearchWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Theme(
//         child: TextField(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               borderSide: BorderSide(
//                 width: 0,
//                 style: BorderStyle.none,
//               ),
//             ),
//             filled: true,
//             prefixIcon: Icon(Icons.search),
//             fillColor: Color(0xFFF2F4F5),
//             hintStyle: TextStyle(color: Colors.grey[600]),
//             hintText: "What would you like to buy?",
//           ),
//           autofocus: false,
//         ),
//         data: Theme.of(context).copyWith(
//           primaryColor: Colors.grey[600],
//         ),
//       ),
//     );
//   }
// }

// class SearchPage extends StatelessWidget {
//   void _navigateToHome(BuildContext context) {
//     Navigator.pushReplacementNamed(context, '/home');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//       ),
//       body: Column(
//         children: [
//           SearchWidget(), // Include the SearchWidget
//           // Add more widgets for search results or filters here
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               _navigateToHome(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.grey[600],
        ),
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            prefixIcon: const Icon(Icons.search),
            fillColor: const Color(0xFFF2F4F5),
            hintStyle: TextStyle(color: Colors.grey[600]),
            hintText: "What would you like to buy?",
          ),
          autofocus: false,
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Column(
        children: [
          SearchWidget(), // Include the SearchWidget
          // Add more widgets for search results or filters here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: 1, // Set the selected index to 1 for the "Search" icon
        selectedItemColor: const Color(0xFFAA292E),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            // Handle Profile icon tap
          } else if (index == 2) {
            _navigateToHome(context);
          } else if (index == 3) {
            // Handle Contact icon tap
          } else if (index == 4) {
            // Handle Logout icon tap
            
          }
        },
        backgroundColor: const Color(0xFF545454),
      ),
    );
  }
}
