import 'package:flutter/material.dart';
import '../../services/product_service.dart';
import 'product_list_screen.dart';

class ProductViewScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductViewScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    final imageUrl = ProductService().imageUrl ?? '';
    final imagePath =
        productData['image'] ?? ''; // ใช้ฟิลด์ image จาก productData

    // ตรวจสอบข้อมูลที่ได้
    print("ProductName Data: $productData"); // เพิ่มการพิมพ์ข้อมูลใน console

    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดสินค้า'),
        backgroundColor: Color(0xFFefbe7e),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปที่หน้าก่อนหน้า
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  '$imageUrl/$imagePath', // ใช้ imagePath ที่ได้รับจาก productData
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/placeholder.png', // Placeholder image
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${productData['productName']?.toString() ?? 'ไม่มีชื่อสินค้า'}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${productData['description']?.toString() ?? 'ไม่มีรายละเอียด'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'ราคา: ${productData['price']?.toString() ?? '0'} บาท',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  backgroundColor: Color(0xFFefbe7e),
                ),
                onPressed: () {
                  // นำทางกลับไปที่ ProductListScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ),
                  );
                },
                label: Text('กลับไปยังรายการสินค้า'),
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
