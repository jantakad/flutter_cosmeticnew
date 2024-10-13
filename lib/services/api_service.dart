import 'dart:convert';
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

  Future<bool> deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/products/$productId'),
    );
    return response.statusCode == 204; // 204 No Content หมายถึงลบสำเร็จ
  }

  Future<bool> updateProduct(int productId, String productName,
      String description, double price, int stockQuantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': productName,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
      }),
    );
    return response.statusCode == 200; // 200 OK หมายถึงอัปเดตสำเร็จ
  }

  Future<Map<String, dynamic>?> getProductDetails(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$productId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
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
}
