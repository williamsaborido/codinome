import 'package:flutter/material.dart';

class DialogHelper {
  static void ShowSnack(BuildContext context, String message) {
    final snack = SnackBar(
      content: Text(message),
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snack);
  }
}
