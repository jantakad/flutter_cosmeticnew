import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'edit_product_screen.dart'; // นำเข้าหน้าจอแก้ไขสินค้า

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final ApiService _apiService = ApiService();

  ProfileScreen({required this.user});

  // ฟังก์ชันลบสินค้า
  void _deleteProduct(BuildContext context, int productId) async {
    final success = await _apiService.deleteProduct(productId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product')),
      );
    }
  }

  // ฟังก์ชันแก้ไขสินค้า
  void _editProduct(BuildContext context, int productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditProductScreen(productId: productId), // ส่ง productId
      ),
    );
  }

  void _deleteAccount(BuildContext context) async {
    final success = await _apiService.deleteAccount(user['userId']);

    if (success) {
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    _editProduct(context, 1), // productId สมมติเป็น 1
                child: Text('Edit Product'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    _deleteProduct(context, 1), // productId สมมติเป็น 1
                child: Text('Delete Product'),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.red, // สีแดงสำหรับปุ่มลบ
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
