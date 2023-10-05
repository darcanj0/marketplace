import 'package:clothing/components/cards/order_card.dart';
import 'package:clothing/components/nav/app_drawer.dart';
import 'package:clothing/model/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderList>(builder: (ctx, orderList, child) {
        return ListView.builder(
          itemCount: orderList.ordersCount,
          itemBuilder: (_, index) => OrderCard(order: orderList.orders[index]),
        );
      }),
      drawer: const AppDrawer(),
    );
  }
}
