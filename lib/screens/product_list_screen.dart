import 'package:flutter/material.dart';
import 'package:flutter_cosmeticnew/screens/product_screen.dart';
import 'package:flutter_cosmeticnew/screens/edit_product_screen.dart'; // เพิ่มการนำเข้า EditProductScreen
import 'product_view_screen.dart';
import '../../services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<dynamic>> futureProduct;

  @override
  void initState() {
    super.initState();
    futureProduct = _fetchProducts();
  }

  Future<List<dynamic>> _fetchProducts() async {
    return await ProductService().fetchProducts();
  }

  void _refreshProducts() {
    setState(() {
      futureProduct = _fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('รายการข้อมูลสินค้า'),
          backgroundColor: Color(0xFFffcccc)),
      body: FutureBuilder<List<dynamic>>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'เกิดข้อผิดพลาด: ${snapshot.error} กรุณาลองใหม่อีกครั้ง.',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('ไม่พบรายการข้อมูลสินค้า'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(product['productName'] ?? 'ชื่อสินค้าไม่ระบุ'),
                    subtitle: Text(
                      'ราคา: ฿${product['price']?.toString() ?? '0'} บาท',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit), // เพิ่มไอคอนแก้ไข
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                              productData:
                                  product, // ส่งข้อมูลสินค้าไปยังหน้าจอแก้ไข
                            ),
                          ),
                        ).then((result) {
                          if (result == true) {
                            _refreshProducts(); // อัปเดตรายการสินค้าเมื่อกลับมา
                          }
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductViewScreen(
                            productData: product,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(),
            ),
          );

          if (result == true) {
            _refreshProducts();
          }
        },
        tooltip: 'เพิ่มข้อมูลสินค้าใหม่',
        child: const Icon(Icons.add),
      ),
    );
  }
}
