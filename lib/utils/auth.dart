import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String? _loggedInUser; // Store the logged-in user's information (e.g., email).

  // Getter to check if a user is logged in.
  bool get isLoggedIn => _loggedInUser != null;

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('your_login_api_url_here');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Check the response data for success or failure.
      if (responseData['success'] == true) {
        _loggedInUser = email;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }
}
