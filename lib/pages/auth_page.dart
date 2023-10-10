import 'dart:math';

import 'package:clothing/components/forms/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(215, 117, 255, .5),
                      Color.fromRGBO(255, 188, 117, .9),
                    ]),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    transform: Matrix4.rotationZ(-4 * pi / 180)..translate(-5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorScheme.primary.withOpacity(.75),
                      border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: const Color.fromARGB(88, 221, 146, 33)),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 4,
                          color: Color.fromRGBO(194, 128, 29, .75),
                        ),
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(-1, -1),
                          color: Color.fromRGBO(248, 164, 37, .75),
                        ),
                      ],
                    ),
                    child: Text(
                      "Dan's Marketplace",
                      style: textTheme.displayLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: AuthForm(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
