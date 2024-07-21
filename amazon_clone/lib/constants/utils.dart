import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String response) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(response),
    ),
  );
}
