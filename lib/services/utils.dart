import 'package:flutter/material.dart';

class Utils {
  //*navigator push no animation
  static void pushReplacementnoanimation(
      {required BuildContext context, required Widget newScreen}) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => newScreen,
      ),
    );
  }

  //*Snackbar
  static void showSnackbar(
      {required BuildContext context,
      required String text,
      Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor ?? Colors.red,
      duration: const Duration(seconds: 5),
    ));
  }

  // Add more functions as needed
}
