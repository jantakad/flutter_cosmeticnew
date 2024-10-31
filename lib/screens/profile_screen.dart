import 'package:flutter/material.dart';
import 'package:flutter_cosmeticnew/screens/edit_profile_screen.dart';
import 'package:flutter_cosmeticnew/screens/product_list_screen.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'product_screen.dart'; // นำเข้า ProductScreen

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final ApiService _apiService = ApiService();

  ProfileScreen({required this.user});

  void _deleteAccount(BuildContext context) async {
    final success = await _apiService.deleteAccount(user['userId']);
    if (success) {
      // Navigate back to LoginScreen after account deletion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text('Welcome, ${user['username']}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Edit profile functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(user: user)),
                  );
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _deleteAccount(context),
                child: Text('Delete Account'),
              ),
              SizedBox(height: 20), // ขนาดว่างเพิ่มระหว่างปุ่ม
              ElevatedButton(
                onPressed: () {
                  // Navigate to ProductScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListScreen()),
                  );
                },
                child: Text(' Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
