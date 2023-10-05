import 'package:flutter/material.dart';

import '../../model/cart.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.item,
  });
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    return Card(
      shape: const ContinuousRectangleBorder(),
      color: colorScheme.primaryContainer,
      margin: const EdgeInsets.all(4),
      child: ListTile(
        title: Text(
          item.productTitle,
          style: textTheme.labelLarge,
        ),
        subtitle: Text(
          '${item.quantity} x U\$ ${item.price}',
          style: textTheme.bodySmall,
        ),
        trailing: Text(
          'U\$ ${(item.price * item.quantity).toStringAsFixed(2)}',
          style: textTheme.bodyMedium,
        ),
      ),
    );
  }
}
