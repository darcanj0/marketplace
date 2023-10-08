import 'package:flutter/material.dart';

import '../../providers/orders_provider.dart';
import '../cards/order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    required this.orderListProvider,
    super.key,
  });

  final OrderListProvider orderListProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderListProvider.ordersCount,
      itemBuilder: (_, index) =>
          OrderCard(order: orderListProvider.orders[index]),
    );
  }
}
