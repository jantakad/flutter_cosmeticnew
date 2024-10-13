import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditProductScreen extends StatefulWidget {
  final int productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String description = '';
  double price = 0.0;
  int stockQuantity = 0;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  void _fetchProductDetails() async {
    // ดึงข้อมูลสินค้าจาก API ตาม productId
    // ต้องเขียนฟังก์ชันดึงข้อมูลที่นี่
  }

  void _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      // ส่งข้อมูลไปยัง API เพื่ออัปเดตสินค้า
      final success = await _apiService.updateProduct(
          widget.productId, productName, description, price, stockQuantity);
      if (success) {
        // ถ้าอัปเดตสำเร็จ
        Navigator.pop(context);
      } else {
        // ถ้าอัปเดตไม่สำเร็จ
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to update product')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
                onChanged: (value) {
                  productName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                onChanged: (value) {
                  price = double.tryParse(value) ?? 0.0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
                onChanged: (value) {
                  stockQuantity = int.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
