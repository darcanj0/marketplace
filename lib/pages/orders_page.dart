import 'package:clothing/components/nav/app_drawer.dart';
import 'package:clothing/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/lists/orders_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderListProvider>().loadOrders().then((_) => setState(
          () => isLoading = false,
        ));
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<OrderListProvider>(
              builder: (ctx, orderListProvider, child) {
              return OrdersList(
                orderListProvider: orderListProvider,
              );
            }),
      drawer: const AppDrawer(),
    );
  }
}
