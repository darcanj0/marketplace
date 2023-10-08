import 'dart:ui';

import 'package:flutter/material.dart';

import '../../helpers/exception_feedback_handler.dart';
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
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad
        },
      ),
      child: RefreshIndicator.adaptive(
        onRefresh: () => productList.loadProducts().catchError(
            (err) => ExceptionFeedbackHandler.withDialog(context, err)),
        child: ListView.builder(
          itemBuilder: (ctx, index) => Column(
            children: [
              ManageProductCard(product: productList.products[index]),
              const Divider()
            ],
          ),
          itemCount: productList.products.length,
        ),
      ),
    );
  }
}
