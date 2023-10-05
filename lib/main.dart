import 'package:clothing/model/cart.dart';
import 'package:clothing/model/order.dart';
import 'package:clothing/pages/cart_page.dart';
import 'package:clothing/pages/orders_page.dart';
import 'package:clothing/pages/product_details_page.dart';
import 'package:clothing/pages/products_page.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 252, 121, 33),
    );

    final TextTheme originalTextTheme = Theme.of(context).textTheme.copyWith(
        headlineMedium: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 32,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 20,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.nunitoTextTheme(originalTextTheme),
        useMaterial3: true,
      ),
      home: const ProductsPage(),
      routes: {
        AppRoutes.home.name: (context) => const ProductsPage(),
        AppRoutes.productDetails.name: (context) => const ProductDetailsPage(),
        AppRoutes.cart.name: (context) => const CartPage(),
        AppRoutes.orders.name: (context) => const OrdersPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
