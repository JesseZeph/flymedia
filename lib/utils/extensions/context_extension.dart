import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void showSnackBar(
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) {
    showSnackBar(
      message,
      color: Colors.red,
    );
  }

  void showSuccess(String message) {
    showSnackBar(
      message,
      color: Colors.green,
    );
  }
}
