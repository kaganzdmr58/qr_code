import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    Color backgroundColor = Colors.blue,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double borderRadius = 10.0,
  }) : super(
          content: Container(
            //height: 50.0,
            alignment: Alignment.center,
            child: Text(
              message,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: behavior,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
}
