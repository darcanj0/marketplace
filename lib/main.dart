import 'package:clothing/constants/server.dart';
import 'package:clothing/model/cart.dart';
import 'package:clothing/pages/auth_page.dart';
import 'package:clothing/providers/auth_provider.dart';
import 'package:clothing/providers/orders_provider.dart';
import 'package:clothing/pages/cart_page.dart';
import 'package:clothing/pages/manage_products_page.dart';
import 'package:clothing/pages/orders_page.dart';
import 'package:clothing/pages/product_details_page.dart';
import 'package:clothing/pages/product_form_page.dart';
import 'package:clothing/pages/home_page.dart';
import 'package:clothing/providers/products_provider.dart';
import 'package:clothing/constants/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
            create: (_) => ProductListProvider(dbPath: DbPaths.products)),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(
            create: (_) => OrderListProvider(dbPath: DbPaths.orders))
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
        displayLarge: TextStyle(
          color: colorScheme.background,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
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
      home: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return StreamBuilder(
            stream: value.firebase.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              }
              return const AuthPage();
            },
          );
        },
      ),
      routes: {
        AppRoutes.home.name: (context) => const HomePage(),
        AppRoutes.productDetails.name: (context) => const ProductDetailsPage(),
        AppRoutes.cart.name: (context) => const CartPage(),
        AppRoutes.orders.name: (context) => const OrdersPage(),
        AppRoutes.manageProducts.name: (context) => const ManageProductsPage(),
        AppRoutes.productForm.name: (context) => const ProductFormPage(),
        AppRoutes.auth.name: (context) => const AuthPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
