import 'package:clothing/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

class ManageProductCard extends StatelessWidget {
  const ManageProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool reduceIcons = mediaQuery.size.width <= 350;
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
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                iconSize: reduceIcons ? 15 : 20,
                icon: const Icon(Icons.edit),
              ),
              if (!reduceIcons)
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
                      context
                          .read<ProductListProvider>()
                          .deleteProduct(product);
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
