import 'package:flutter/material.dart';

import '../../model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_outlined,
              ),
            ),
            title: Text(product.title),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            backgroundColor: colorScheme.onPrimaryContainer.withOpacity(.65),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          )),
    );
  }
}
