import 'package:clothing/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_page.dart';
import 'home_page.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
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
    );
  }
}
