import 'package:clothing/helpers/exception_feedback_handler.dart';
import 'package:clothing/helpers/http_exception.dart';
import 'package:clothing/model/cart.dart';
import 'package:clothing/model/product.dart';
import 'package:clothing/constants/app_routes.dart';
import 'package:clothing/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added ${product.title} to Cart'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () => cart.removeOneItem(product.id),
                  ),
                ));
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
                builder: (_, prod, __) => Consumer<AuthProvider>(
                  builder: (context, authProvider, __) => IconButton(
                    onPressed: () {
                      prod
                          .toggleFavorite(
                              authProvider.firebase.currentUser?.uid ?? '')
                          .catchError(
                            (err) => ExceptionFeedbackHandler.withSnackbar(
                                context, err),
                            test: (error) => error is AppHttpException,
                          );
                    },
                    icon: Icon(
                      prod.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: iconSize,
                      color: colorScheme.primary,
                    ),
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
