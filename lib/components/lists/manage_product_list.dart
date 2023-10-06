import 'package:flutter/material.dart';

import '../../providers/products_provider.dart';
import '../cards/manage_product_card.dart';

class ManageProductList extends StatelessWidget {
  const ManageProductList({
    required this.productList,
    super.key,
  });

  final ProductListProvider productList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ManageProductCard(product: productList.products[index]),
          const Divider()
        ],
      ),
      itemCount: productList.products.length,
    );
  }
}
