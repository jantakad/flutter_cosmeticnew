import 'package:flutter/material.dart';
import '../../services/product_service.dart';
import 'product_list_screen.dart';

class ProductViewScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const ProductViewScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    final imageUrl = ProductService().imageUrl ?? '';
    final imagePath = productData['image'] ?? '';

    // ตรวจสอบข้อมูลที่ได้
    print("ProductName Data: $productData"); // เพิ่มการพิมพ์ข้อมูลใน console

    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดสินค้า'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                '$imageUrl/$imagePath',
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      'assets/placeholder.png'); // Placeholder image
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${productData['productName']?.toString() ?? '0'} ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '${productData['description']?.toString() ?? '0'} ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '${productData['price']?.toString() ?? '0'} บาท',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
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
    );
  }
}
