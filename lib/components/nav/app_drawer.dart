import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void navigateTo(BuildContext context, AppRoutes route) {
    Navigator.of(context).pushReplacementNamed(route.name);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome, User'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Shop'),
            onTap: () => navigateTo(context, AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Orders'),
            onTap: () => navigateTo(context, AppRoutes.orders),
          ),
        ],
      ),
    );
  }
}
