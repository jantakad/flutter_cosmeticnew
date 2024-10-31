import 'package:flutter/material.dart';
import 'package:flutter_cosmeticnew/screens/product_list_screen.dart';
import 'package:flutter_cosmeticnew/screens/product_screen.dart';
import '../../services/product_service.dart';

// ignore: must_be_immutable
class ProductDtailScreen extends StatefulWidget {
  final ProductScreen data;

  ProductDtailScreen({super.key, required this.data});

  @override
  State<ProductDtailScreen> createState() => _ProductDtailScreen();
}

class _ProductDtailScreen extends State<ProductDtailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name ?? 'ไม่มีชื่อสินค้า'), // ใช้ชื่อที่ปลอดภัย
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                widget.data.imgUrl ??
                    'assets/placeholder.png', // ใช้ placeholder ถ้า imgUrl เป็น null
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      'assets/placeholder.png'); // Placeholder image
                },
              ),
              SizedBox(height: 20),
              Text(
                widget.data.name ?? 'ไม่มีชื่อสินค้า', // ใช้ชื่อที่ปลอดภัย
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                widget.data.detail ??
                    'ไม่มีรายละเอียด', // ใช้รายละเอียดที่ปลอดภัย
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
