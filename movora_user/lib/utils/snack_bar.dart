import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void snackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
