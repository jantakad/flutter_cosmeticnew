import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _addProduct() async {
    final name = _productNameController.text;
    final description = _productDescriptionController.text;
    final price = double.tryParse(_productPriceController.text) ?? 0.0;
    final stockQuantity = int.tryParse(_productStockController.text) ?? 0;

    final response =
        await _apiService.addproduct(name, description, price, stockQuantity);

    if (response != null) {
      // Navigate back to the previous screen or product list
      Navigator.pop(context);
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product addition failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการสินค้า'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _productDescriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _productStockController,
              decoration: InputDecoration(labelText: 'Stock Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addProduct, child: Text('Add Product')),
          ],
        ),
      ),
    );
  }
}
