import 'package:clothing/model/product.dart';
import 'package:flutter/material.dart';

import '../components/cards/product_card.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({super.key});

  final List<Product> mockedProducts = mockProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: mockedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (ctx, index) =>
            ProductCard(product: mockedProducts[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
