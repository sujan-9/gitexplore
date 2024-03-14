import 'package:flutter/material.dart';

void showSnackBar(String content, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(
      content,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 1500),
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
