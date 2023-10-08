import 'package:clothing/helpers/http_exception.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

class ManageProductCard extends StatelessWidget {
  const ManageProductCard({required this.product, super.key});

  final Product product;

  void editProduct(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.productForm.name, arguments: product);
  }

  Future<void> deleteProduct(BuildContext context) async {
    try {
      await context.read<ProductListProvider>().deleteProduct(product);
    } on AppHttpException catch (err) {
      showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('Error when deleting product!'),
                  content: Text(err.msg),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Ok'))
                  ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool reduceIcons = mediaQuery.size.width <= 350;
    final bool displaySizedBox = mediaQuery.size.width > 400;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: reduceIcons ? 20 : 40,
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        title: Text(product.title),
        trailing: SizedBox(
          width: reduceIcons ? 100 : 130,
          child: Row(
            children: [
              IconButton(
                onPressed: () => editProduct(context),
                iconSize: reduceIcons ? 15 : 20,
                icon: const Icon(Icons.edit),
              ),
              if (displaySizedBox)
                const SizedBox(
                  width: 10,
                ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'Do you want to delete this product?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('YES'),
                              ),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('NO'))
                            ],
                          )).then((confirmDeletion) {
                    if (confirmDeletion) {
                      deleteProduct(context);
                    }
                  });
                },
                iconSize: reduceIcons ? 15 : 20,
                color: colorScheme.error,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
