import 'package:flutter/material.dart';

import '../../model/cart.dart';
import '../cards/cart_item_card.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    super.key,
    required this.items,
  });

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        final CartItem item = items[index];
        return CartItemCard(
          cartItem: item,
          key: Key(item.productId),
        );
      },
    );
  }
}
