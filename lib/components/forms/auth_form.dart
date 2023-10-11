import 'package:clothing/helpers/string_validation.dart';
import 'package:flutter/material.dart';

enum AuthMode { login, signup }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode authMode = AuthMode.signup;
  bool get isLogin => authMode == AuthMode.login;
  bool get isSignup => authMode == AuthMode.signup;

  Map<String, String> formData = {'email': '', 'password': ''};
  final passwordController = TextEditingController();
  final authFormKey = GlobalKey<FormState>();

  void submitForm() {
    final formState = authFormKey.currentState;
    if (formState!.validate()) {
      setState(() => isLoading = true);
      formState.save();

      if (isLogin) {
      } else {}

      setState(() => isLoading = false);
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: Container(
        height: isLogin ? 350 : 400,
        width: deviceWidth * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  onPressed: () => setState(() => isLogin
                      ? authMode = AuthMode.signup
                      : authMode = AuthMode.login),
                  child:
                      Text(isLogin ? 'New user?' : 'Already have an account?'),
                )
              ],
            )),
      ),
    );
  }
}
