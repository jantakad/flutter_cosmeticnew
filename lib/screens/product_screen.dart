// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import 'dart:io';

class ProductScreen extends StatefulWidget {
  get detail => null;

  get name => null;

  get imgUrl => null;

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

  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _addProduct() async {
    final name = _productNameController.text;
    final description = _productDescriptionController.text;
    final price = double.tryParse(_productPriceController.text) ?? 0.0;
    final stockQuantity = int.tryParse(_productStockController.text) ?? 0;

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณาถ่ายรูปสินค้าก่อนเพิ่มข้อมูล')),
      );
      return;
    }

    final response = await _apiService.addProductWithImage(
      name,
      description,
      price,
      stockQuantity,
      _image!,
    );

    if (response != null) {
      Navigator.pop(context);
    } else {
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
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Capture Image'),
            ),
            SizedBox(height: 20),
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
