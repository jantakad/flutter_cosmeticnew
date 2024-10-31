import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://cosmeticnew.onrender.com/api/'; // URL ของ RESTful API

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // ฟังก์ชันสำหรับเพิ่มสินค้า
  Future<Map<String, dynamic>?> addProduct(String productName,
      String description, double price, int stockQuantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'), // URL สำหรับเพิ่มสินค้า
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productName': productName, // ชื่อฟิลด์ต้องตรงกับฐานข้อมูล
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body); // ส่งกลับข้อมูลที่ได้รับจากฐานข้อมูล
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> signup(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future<bool> deleteAccount(int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
    );
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>?> updateProfile(
      int userId, String username, String email, String password) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // ฟังก์ชันสำหรับดึงข้อมูลสินค้าทั้งหมด
  Future<List<Map<String, dynamic>>?> fetchProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'), // URL สำหรับดึงข้อมูลสินค้า
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> products = jsonDecode(response.body);
      return products
          .map((product) => product as Map<String, dynamic>)
          .toList();
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      return null;
    }
  }

  // ฟังก์ชันสำหรับอัปเดตสินค้า
  Future<Map<String, dynamic>?> updateProduct(
      String productId,
      String productName,
      String description,
      double price,
      int stockQuantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$productId'), // ใช้ productId ที่ถูกส่งมา
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productName': productName, // ชื่อฟิลด์ต้องตรงกับฐานข้อมูล
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // ส่งกลับข้อมูลที่ได้รับจากฐานข้อมูล
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      return null;
    }
  }

  addProductWithImage(String name, String description, double price,
      int stockQuantity, File file) {}
}
