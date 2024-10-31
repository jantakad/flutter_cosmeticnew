import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://cosmeticnew.onrender.com/api/'; // URL ของ RESTful API

  // ฟังก์ชันสำหรับเข้าสู่ระบบ
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

  // ฟังก์ชันสำหรับสมัครสมาชิก
  Future<Map<String, dynamic>?> signup(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    // ตรวจสอบสถานะการตอบกลับ
    if (response.statusCode == 201) {
      return jsonDecode(response.body); // ส่งกลับข้อมูลที่ได้รับจากฐานข้อมูล
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      return null; // หรือคุณสามารถส่งข้อความข้อผิดพลาดกลับได้
    }
  }

  // ฟังก์ชันสำหรับเพิ่มสินค้า
  Future<Map<String, dynamic>?> addProduct(String productName,
      String description, double price, int stockQuantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'), // URL สำหรับเพิ่มสินค้า
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productName': productName,
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

  // ฟังก์ชันสำหรับเพิ่มสินค้าพร้อมรูปภาพ
  Future<dynamic> addProductWithImage(String name, String description,
      double price, int stockQuantity, File imageFile) async {
    final url = '$baseUrl/products'; // ใช้ URL สำหรับเพิ่มสินค้า
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // สร้าง FormData สำหรับการส่งข้อมูล
    request.fields['productName'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['stockQuantity'] = stockQuantity.toString();

    // เพิ่มไฟล์รูปภาพ
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  // ฟังก์ชันสำหรับลบบัญชีผู้ใช้
  Future<bool> deleteAccount(int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
    );
    return response.statusCode == 200;
  }

  // ฟังก์ชันสำหรับอัปเดตโปรไฟล์ผู้ใช้
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
        'productName': productName,
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
}
