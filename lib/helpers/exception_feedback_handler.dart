import 'package:clothing/helpers/http_exception.dart';
import 'package:flutter/material.dart';

class ExceptionFeedbackHandler {
  static Future<void> withSnackbar(
      BuildContext context, AppHttpException err) async {}

  static Future<void> withDialog(
      BuildContext context, AppHttpException err) async {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('An error occurred!'),
          content: Text('${err.toString()} [CODE ${err.statusCode}]'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'))
          ]),
    );
  }
}
