import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ProductSelectionScreen extends StatefulWidget {
  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  final List<Product> products = [
    Product('Chicken', 2.00),
    Product('Beef', 3.00),
    // ... باقي المنتجات
  ];
  List<double> selectedProductPrices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تطبيق حساب السعر'),
      ),
      body: Column(
        children: [
          // ... باقي المحتوى
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return CheckboxListTile(
                  title: Text(product.name),
                  value: selectedProductPrices.contains(product.price),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        selectedProductPrices.add(product.price);
                      } else {
                        selectedProductPrices.remove(product.price);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
