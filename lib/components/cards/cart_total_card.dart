import 'package:clothing/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';

class CartTotalCard extends StatelessWidget {
  const CartTotalCard(
      {super.key, required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: colorScheme.tertiaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Chip(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: colorScheme.background,
              label: FittedBox(
                child: Text(
                  'U\$ ${cart.totalPrice.toStringAsFixed(2)}',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 1,
              child: TextButton(
                onPressed: cart.itemsCount == 0
                    ? null
                    : () async {
                        await context.read<OrderListProvider>().addOrder(cart);
                        cart.emptyCart();
                      },
                child: FittedBox(
                  child: Text(
                    'Checkout',
                    style: textTheme.labelLarge
                        ?.copyWith(color: colorScheme.primary, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
