import 'package:flutter/material.dart';
import 'package:flutter_cosmeticnew/screens/product_screen.dart';

// ignore: must_be_immutable
class ProductDtailScreen extends StatefulWidget {
  ProductScreen data;

  var _widget;
  ProductDtailScreen({super.key, required this.data});

  @override
  State<ProductDtailScreen> createState() => _ProductDtailScreen();
}

class _ProductDtailScreen extends State<ProductDtailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                widget._widget!.imgUrl,
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                widget.data.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(widget._widget!.detail),
            ],
          ),
        ),
      ),
    );
  }
}
