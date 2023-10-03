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
      providers: [ChangeNotifierProvider(create: (_) => ProductsProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 214, 75, 33),
    );

    final TextTheme originalTextTheme = Theme.of(context).textTheme.copyWith(
          labelSmall: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.nunitoTextTheme(originalTextTheme),
        useMaterial3: true,
      ),
      home: const ProductsPage(),
      routes: {
        AppRoutes.home.name: (context) => ProductsPage(),
        AppRoutes.productDetails.name: (context) => const ProductDetailsPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
