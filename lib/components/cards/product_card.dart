import 'package:clothing/model/cart.dart';
import 'package:clothing/model/product.dart';
import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });
  static const double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context, listen: true);
    final Product product = Provider.of<Product>(context, listen: false);

    void selectProduct() {
      Navigator.of(context)
          .pushNamed(AppRoutes.productDetails.name, arguments: product);
    }

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: () => selectProduct(),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: colorScheme.primary.withOpacity(.7),
            title: Text(
              product.title,
              style: textTheme.labelMedium,
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addProduct(product);
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: iconSize,
              ),
            ),
          ),
          child: Stack(children: [
            Positioned.fill(
              child: Ink.image(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Consumer<Product>(
                builder: (context, value, child) => IconButton(
                  onPressed: value.toggleFavorite,
                  icon: Icon(
                    value.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    size: iconSize,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
