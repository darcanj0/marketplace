import 'package:clothing/components/cards/manage_product_card.dart';
import 'package:clothing/components/nav/app_drawer.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Consumer<ProductListProvider>(
          builder: (context, productList, child) {
            return ListView.builder(
              itemBuilder: (ctx, index) =>
                  ManageProductCard(product: productList.products[index]),
              itemCount: productList.products.length,
            );
          },
        ),
      ),
    );
  }
}
