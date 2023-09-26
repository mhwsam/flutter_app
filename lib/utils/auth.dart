import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData {
  final String name;
  final String email;

  UserData({
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
    );
  }
}

class AuthProvider with ChangeNotifier {
  String?
      _loggedInUser; // Store the logged-in user's information (e.g., email).

  // Getter to check if a user is logged in.
  bool get isLoggedIn => _loggedInUser != null;

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('http://13.213.35.25/api/v1/auth/login');
    print('Email from auth: $email');
    print('Password from auth: $password');
    print('Before HTTP POST request');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    print('After HTTP POST request');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
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
