import 'package:flutter/material.dart';

class Toastutil {
  static void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(40)),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(msg, textAlign: TextAlign.center),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}
