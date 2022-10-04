import 'package:flutter/material.dart';

class CustomBackButton extends IconButton {
  final BuildContext context;
  final Color buttonColor;
  final void Function()? onTap;
  CustomBackButton(
    this.context, {
    Key? key,
    this.buttonColor = Colors.black,
    this.onTap,
  }) : super(
            key: key,
            onPressed: onTap ?? () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color:
                  buttonColor /* ?? Theme.of(context).colorScheme.tertiary */,
            ));
}
