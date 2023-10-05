import 'package:clothing/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: Column(
        children: [
          Container(
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
                    label: Text(
                      'U\$ ${context.watch<Cart>().totalPrice.toStringAsFixed(2)}',
                      style: textTheme.labelLarge,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Checkout',
                        style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.primary, fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
