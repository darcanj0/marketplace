import 'package:clothing/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../cards/product_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Product> products = context.watch<ProductsProvider>().products;
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2.5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ProductCard(product: products[index]),
    );
  }
}
