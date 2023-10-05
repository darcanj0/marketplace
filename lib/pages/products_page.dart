import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/lists/products_grid.dart';
import '../model/cart.dart';
import 'package:badges/badges.dart' as badges;

enum Filters { all, favorites }

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool showFavoritesOnly = false;

  void navigateToCart() => Navigator.of(context).pushNamed(AppRoutes.cart.name);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: Filters.all,
                child: Text(
                  'Show all',
                  style: textTheme.bodyMedium,
                ),
              ),
              PopupMenuItem(
                value: Filters.favorites,
                child: Text(
                  'Show Favorites only',
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case Filters.all:
                  setState(() => showFavoritesOnly = false);
                case Filters.favorites:
                  setState(() => showFavoritesOnly = true);
              }
            },
          ),
        ],
      ),
      body: ProductsGrid(showFavoritesOnly: showFavoritesOnly),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToCart,
        child: badges.Badge(
          badgeContent: Text(
            context.read<Cart>().itemsCount.toString(),
            style: textTheme.labelSmall,
          ),
          showBadge: context.watch<Cart>().itemsCount != 0,
          badgeStyle: badges.BadgeStyle(
            badgeColor: colorScheme.primary,
          ),
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
