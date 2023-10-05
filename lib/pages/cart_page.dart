import 'package:clothing/components/cards/cart_item_card.dart';
import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cards/cart_total_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<Cart>(builder: (context, cart, child) {
        final items = cart.items.values.toList();
        return Column(
          children: [
            CartTotalCard(
              colorScheme: colorScheme,
              textTheme: textTheme,
              cartTotal: cart.totalPrice,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, index) {
                  final CartItem item = items[index];
                  return CartItemCard(
                    cartItem: item,
                    key: Key(item.productId),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
