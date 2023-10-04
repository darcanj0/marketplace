import 'package:flutter/material.dart';
import '../components/lists/products_grid.dart';

enum Filters { all, favorites }

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: Filters.all, child: Text('Show all')),
              const PopupMenuItem(
                  value: Filters.favorites, child: Text('Show Favorites only')),
            ],
            onSelected: (value) {
              switch (value) {
                case Filters.all:
                  setState(() => showFavoritesOnly = false);
                case Filters.favorites:
                  setState(() => showFavoritesOnly = true);
              }
            },
          )
        ],
      ),
      body: ProductsGrid(showFavoritesOnly: showFavoritesOnly),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
