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
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Theme(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            prefixIcon: Icon(Icons.search),
            fillColor: Color(0xFFF2F4F5),
            hintStyle: TextStyle(color: Colors.grey[600]),
            hintText: "What would you like to buy?",
          ),
          autofocus: false,
        ),
        data: Theme.of(context).copyWith(
          primaryColor: Colors.grey[600],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          SearchWidget(), // Include the SearchWidget
          // Add more widgets for search results or filters here
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              _navigateToHome(context);
            },
          ),
        ],
      ),
    );
  }
}
