import 'package:flutter/material.dart';

class CustomElevatedButton extends ElevatedButton {
  final BuildContext context;
  final void Function()? onTap;
  final String title;
  final Color? color;
  final Widget? icon;
  CustomElevatedButton(
    this.context, {
    Key? key,
    this.onTap,
    required this.title,
    this.color,
    this.icon,
  }) : super(
            key: key,
            style: ElevatedButton.styleFrom(
              primary: color,
              elevation: 4,
              textStyle: Theme.of(context).textTheme.button,
              fixedSize: const Size(double.maxFinite, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onTap,
            child: icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(title), const SizedBox(width: 8), icon],
                  )
                : Text(title));
}
