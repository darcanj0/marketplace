import 'package:clothing/components/nav/app_drawer.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/lists/manage_product_list.dart';

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  void navigateToProductForm(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRoutes.productForm.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
              onPressed: () => navigateToProductForm(context),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Consumer<ProductListProvider>(
          builder: (context, productList, child) {
            return ManageProductList(
              productList: productList,
            );
          },
        ),
      ),
    );
  }
}
