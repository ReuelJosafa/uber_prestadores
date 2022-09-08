import 'package:flutter/material.dart';

class CustomBackButton extends IconButton {
  final BuildContext context;
  final Color buttonColor;
  CustomBackButton(
    this.context, {
    Key? key,
    this.buttonColor = Colors.black,
  }) : super(
            key: key,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: buttonColor /* ?? Theme.of(context).colorScheme.tertiary */,
            ));
}
