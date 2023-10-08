import 'package:clothing/helpers/exception_feedback_handler.dart';
import 'package:clothing/model/product.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cards/product_grid_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    required this.showFavoritesOnly,
    super.key,
  });

  final bool showFavoritesOnly;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListProvider>(context);
    final List<Product> loadedProducts =
        showFavoritesOnly ? provider.favoriteProducts : provider.products;

    return RefreshIndicator.adaptive(
      onRefresh: () => provider.loadProducts().catchError(
          (err) => ExceptionFeedbackHandler.withDialog(context, err)),
      child: GridView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: ProductGridCard(key: Key(loadedProducts[index].id)),
          );
        },
      ),
    );
  }
}
