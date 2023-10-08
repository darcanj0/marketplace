import 'package:clothing/components/nav/app_drawer.dart';
import 'package:clothing/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/lists/orders_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body:
          Consumer<OrderListProvider>(builder: (ctx, orderListProvider, child) {
        return OrdersList(
          orderListProvider: orderListProvider,
        );
      }),
      drawer: const AppDrawer(),
    );
  }
}
