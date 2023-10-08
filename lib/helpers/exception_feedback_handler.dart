import 'package:clothing/helpers/http_exception.dart';
import 'package:flutter/material.dart';

class ExceptionFeedbackHandler {
  static Future<void> withSnackbar(
      BuildContext context, AppHttpException err) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(err.msg),
      duration: const Duration(seconds: 3),
    ));
  }

  static Future<void> withDialog(
      BuildContext context, AppHttpException err) async {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('An error occurred!'),
          content: Text('${err.msg} [CODE ${err.statusCode}]'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'))
          ]),
    );
  }
}
