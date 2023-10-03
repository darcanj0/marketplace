import 'package:clothing/pages/products_page.dart';
import 'package:clothing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
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
      home: ProductsPage(),
      routes: {
        AppRoutes.home.name: (context) => ProductsPage(),
        AppRoutes.productDetails.name: (context) => ProductsPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
