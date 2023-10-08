import 'dart:ui';
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
        onRefresh: () => orderListProvider.loadOrders(),
        child: ListView.builder(
          itemCount: orderListProvider.ordersCount,
          itemBuilder: (_, index) =>
              OrderCard(order: orderListProvider.orders[index]),
        ),
      ),
    );
  }
}
