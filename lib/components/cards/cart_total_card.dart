import 'package:flutter/material.dart';

class CartTotalCard extends StatelessWidget {
  const CartTotalCard(
      {super.key,
      required this.colorScheme,
      required this.textTheme,
      required this.cartTotal});

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final double cartTotal;

  @override
  Widget build(BuildContext context) {
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
                  'U\$ ${cartTotal.toStringAsFixed(2)}',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 1,
              child: TextButton(
                onPressed: () {},
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
