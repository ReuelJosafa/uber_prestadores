import 'package:flutter/material.dart';

class TextFieldStyle extends InputDecoration {
  final String text;
  final Widget trailingIcon;

  TextFieldStyle({required this.text, required this.trailingIcon})
      : super(
            contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            constraints: const BoxConstraints(maxHeight: 50),
            hintText: text,
            suffixIcon: trailingIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ));
}
