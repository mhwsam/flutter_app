import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burobd/utils/auth.dart';
import 'package:burobd/screens/search_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  int _selectedIndex = 2; // Default selected index is 2 (Home)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 4) {
        // Logout when the last item (Logout) is tapped
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.logout();
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final apiResponse = authProvider.apiResponse;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FairElectronics Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(), // Enable scrolling
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Text('Welcome to the Home Screen', style: TextStyle(fontSize: 20)),

          // Search Bar with Icons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
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
                const Text('API Response Data:'),
                // Display the API response data here as needed
                // Example: Display the user's name
                Text('User Name: ${apiResponse['user']['name']}'),
                Text('Phone Number: ${apiResponse['user']['phone']}'),
                // Add more widgets to display other data from the API response
              ],
            ),
          // ... (Other widgets you want to display)

          // Add the GridView for categories
          const Center(child: Text('All Categories', style: TextStyle(fontSize: 20))),
          GridView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns in the grid
            ),
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index]);
            },
          ),
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
        currentIndex: _selectedIndex,
         selectedItemColor: const Color(0xFFAA292E),
         unselectedItemColor: Colors.grey, // Color for unselected items
          onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 1) { // Check if the Search icon is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()), // Navigate to SearchPage
      );
    }
     if (index == 4) { // Check if the "Logout" icon is tapped
      authProvider.logout();
      Navigator.pushReplacementNamed(context, '/login');
    } 
  },
         backgroundColor: const Color(0xFF545454),
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

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          if (category.name == 'Mobile' && authProvider.isLoggedIn) {
            Navigator.pushNamed(context, '/mobile'); // Navigate to MobilePage
          } else if (category.name == 'TV' && authProvider.isLoggedIn) {
            Navigator.pushNamed(context, '/tv'); // Navigate to TVPage
          } else if (category.name == 'Refrigerator' &&
              authProvider.isLoggedIn) {
            Navigator.pushNamed(
                context, '/refrigerator'); // Navigate to RefrigeratorPage
          } else if (category.name == 'Washing Machine' &&
              authProvider.isLoggedIn) {
            Navigator.pushNamed(context, '/washingmachine');
          } else if (!authProvider.isLoggedIn) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please log in to access this feature.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 22),
            const SizedBox(height: 10),
            Text(category.name, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
