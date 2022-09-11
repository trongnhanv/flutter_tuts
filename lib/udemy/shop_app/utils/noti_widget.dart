import 'package:flutter/material.dart';

class NotiWidget {
  void showSnackBar(BuildContext context, String message) {
    var snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<void> showAlertDialog(
    BuildContext context, {
    String title = 'Confirm Title',
    String content = 'Alert Content',
    String okText = 'OK',
    String cancelText = '',
  }) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(_).pop(true);
                  },
                  child: Text(okText)),
              if (cancelText.isNotEmpty)
                TextButton(
                    onPressed: () {
                      Navigator.of(_).pop(false);
                    },
                    child: Text(cancelText))
            ],
          );
        });
  }
}
