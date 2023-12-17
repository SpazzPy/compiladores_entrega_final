import 'package:flutter/material.dart';

Widget boldText({
  String message = "Default Message",
  Color textColor = Colors.black,
}) {
  return Container(
    child: Text(
      message,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );
}
