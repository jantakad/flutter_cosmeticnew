import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://cosmeticnew.onrender.com/api/';

  get imageUrl => null;

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Map<String, dynamic>?> addProduct(String productName,
      String productDescription, double productPrice, int stockQuantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productName': productName,
        'description': productDescription,
        'price': productPrice,
        'stockQuantity': stockQuantity,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return null;
  }

  updateProduct(productData, File file, String proname, double price, int i) {}

  deleteProduct(productData) {}
}
