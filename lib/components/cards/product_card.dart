import 'package:flutter/material.dart';

import '../../model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;
  static const double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            style: textTheme.labelSmall,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
              size: iconSize,
            ),
          ),
          backgroundColor: colorScheme.primary.withOpacity(.65),
        ),
        child: Stack(children: [
          Positioned.fill(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border_outlined,
                size: iconSize,
                color: colorScheme.primary,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
