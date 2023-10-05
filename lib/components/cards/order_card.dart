import 'package:clothing/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      child: ListTile(
        title: Text(
          'U\$ ${order.totalPrice.toStringAsFixed(2)}',
          style: textTheme.labelLarge,
        ),
        subtitle: Text(
          DateFormat('MM/dd/yyyy HH:mm').format(order.orderedAt),
          style: textTheme.bodySmall,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.expand_more_rounded),
          iconSize: 30,
        ),
      ),
    );
  }
}
