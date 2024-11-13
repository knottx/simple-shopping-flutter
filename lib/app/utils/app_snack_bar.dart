import 'package:flutter/material.dart';

class AppSnackBar {
  static void error(
    BuildContext context, {
    required Object? error,
  }) {
    final errorMessage =
        error is FormatException ? error.message : error.toString();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Row(
          children: [
            Expanded(
              child: Text(errorMessage),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
