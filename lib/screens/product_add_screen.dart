import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'product_view_screen.dart';

class ProductAddScreen extends StatefulWidget {
  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _addProduct() async {
    final productName = _productNameController.text;
    final description = _productDescriptionController.text;
    final price = double.tryParse(_productPriceController.text) ?? 0.0;
    final stockQuantity = int.tryParse(_productStockController.text) ?? 0;

    final response = await _apiService.addProduct(
        productName, description, price, stockQuantity);

    if (response != null) {
      // นำทางไปยัง ProductViewScreen โดยส่งข้อมูลสินค้าที่เพิ่ม
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductViewScreen(productData: response),
        ),
      );
    } else {
      // แสดงข้อความแสดงข้อผิดพลาด
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถเพิ่มสินค้าได้')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มสินค้า'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
            ),
            TextField(
              controller: _productDescriptionController,
              decoration: InputDecoration(labelText: 'รายละเอียดสินค้า'),
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(labelText: 'ราคา'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _productStockController,
              decoration: InputDecoration(labelText: 'จำนวนในสต๊อก'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('เพิ่มสินค้า'),
            ),
          ],
        ),
      ),
    );
  }
}
