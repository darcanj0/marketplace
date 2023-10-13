import 'package:clothing/constants/app_routes.dart';
import 'package:clothing/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void navigateToReplacing(BuildContext context, AppRoutes route) {
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
            onTap: () => navigateToReplacing(context, AppRoutes.home),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Orders'),
            onTap: () => navigateToReplacing(context, AppRoutes.orders),
          ),
          ListTile(
            leading: const Icon(Icons.edit_rounded),
            title: const Text('Manage Products'),
            onTap: () => navigateToReplacing(context, AppRoutes.manageProducts),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () async {
              navigateToReplacing(context, AppRoutes.home);
              await context.read<AuthProvider>().signout();
            },
          ),
        ],
      ),
    );
  }
}
