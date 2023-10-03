import 'package:clothing/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cards/product_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (context, value, child) => GridView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: value.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: value.products[index],
          child: const ProductCard(),
        ),
      ),
    );
  }
}
