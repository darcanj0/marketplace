import 'package:clothing/helpers/exception_feedback_handler.dart';
import 'package:clothing/helpers/http_exception.dart';
import 'package:clothing/helpers/string_validation.dart';
import 'package:clothing/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { login, signup }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode authMode = AuthMode.login;
  bool get isLogin => authMode == AuthMode.login;
  bool get isSignup => authMode == AuthMode.signup;

  void toggleAuthMode() {
    setState(() {
      if (isLogin) {
        authMode = AuthMode.signup;
        animationController.forward();
      } else {
        authMode = AuthMode.login;
        animationController.reverse();
      }
    });
  }

  Map<String, String> formData = {'email': '', 'password': ''};
  final passwordController = TextEditingController();
  final authFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  late AnimationController animationController;
  late Animation<Size> heightAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    heightAnimation = Tween<Size>(
            begin: const Size(double.infinity, 350),
            end: const Size(double.infinity, 430))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> submitForm() async {
      final formState = authFormKey.currentState;
      if (formState!.validate()) {
        setState(() => isLoading = true);
        formState.save();

        final AuthProvider authProvider = context.read<AuthProvider>();
        if (isLogin) {
          try {
            await authProvider.login(formData);
          } on AppHttpException catch (err) {
            await ExceptionFeedbackHandler.withSnackbar(context, err);
          }
        } else {
          try {
            await authProvider.signup(formData);
          } on AppHttpException catch (err) {
            await ExceptionFeedbackHandler.withSnackbar(context, err);
          }
        }
      }
    }

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: AnimatedBuilder(
        animation: heightAnimation,
        builder: (ctx, child) => Container(
          // height: isLogin ? 350 : 430,
          height: heightAnimation.value.height,
          width: deviceWidth * 0.75,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: child,
        ),
        child: Form(
            key: authFormKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (email) => formData['email'] = email ?? '',
                  validator: (value) {
                    final String email = value ?? '';
                    if (!email.trim().contains('@') ||
                        email.isEmpty ||
                        !email.endsWith('.com')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  onSaved: (password) => formData['password'] = password ?? '',
                  validator: (value) {
                    final String password = value ?? '';
                    return const StringValidationComposite(validations: [
                      IsEmptyStringValidation(),
                      IsTooShortString(size: 6),
                      IsTooLongString(size: 20)
                    ]).validate(password);
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                if (isSignup)
                  TextFormField(
                    validator: (value) {
                      if (isLogin) return null;
                      final String confirmation = value ?? '';
                      if (confirmation.isEmpty ||
                          confirmation != passwordController.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : ElevatedButton(
                        onPressed: submitForm,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            enableFeedback: true,
                            elevation: 5,
                            foregroundColor: colorScheme.background,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Text(
                          isSignup ? 'Register' : 'Login',
                        ),
                      ),
                const Divider(
                  height: 30,
                ),
                TextButton(
                  onPressed: toggleAuthMode,
                  child:
                      Text(isLogin ? 'New user?' : 'Already have an account?'),
                )
              ],
            )),
      ),
    );
  }
}
