import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/main.dart';

class NotifUtils {
  static void showSnackbar(String message,
      {Color? backgroundColor, SnackBarAction? action}) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        action: action,
        content: Text(
          message,
        ),
      ),
    );
  }
}
