import 'package:clothing/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/cart.dart';
import 'order_item_card.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      child: ExpansionTile(
        backgroundColor: colorScheme.primaryContainer,
        leading: FittedBox(child: Text('#${order.id.substring(0, 8)}')),
        title: Text(
          'U\$ ${order.totalPrice.toStringAsFixed(2)}',
          style: textTheme.labelLarge,
        ),
        subtitle: Text(
          DateFormat('MM/dd/yyyy HH:mm').format(order.orderedAt),
          style: textTheme.bodySmall,
        ),
        trailing: const Icon(
          Icons.expand_more_rounded,
          size: 30,
        ),
        children: [
          SizedBox(
            height: 175,
            child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (ctx, index) {
                  final CartItem item = order.items[index];
                  return OrderItemCard(
                    item: item,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
