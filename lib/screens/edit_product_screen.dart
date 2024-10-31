import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  const EditProductScreen({Key? key, required this.productData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: productData['productName']);
    final TextEditingController priceController =
        TextEditingController(text: productData['price'].toString());
    final TextEditingController quantityController =
        TextEditingController(text: productData['quantity'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'ราคา'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'จำนวนสินค้า'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // เพิ่มการอัปเดตข้อมูลสินค้าในที่นี้
                Navigator.pop(
                    context, true); // ส่งกลับค่า true เพื่อบอกให้รีเฟรชรายการ
              },
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}
