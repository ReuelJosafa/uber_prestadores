import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogUtils {
  static Future<T> showAlertDialog<T>(
    BuildContext context, {
    required String title,
    String? contentText,
    Widget? contentWidget,
    String confirmationButtonText = 'Ok',
    String? cancelButtonText,
    void Function()? onConfirmationPressed,
    void Function()? onCancelPressed,
  }) async {
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: contentWidget ?? Text(contentText!),
            actions: [
              if (cancelButtonText != null)
                TextButton(
                    onPressed:
                        onCancelPressed ?? () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(
                        textStyle: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(fontSize: 14)),
                    child: Text(cancelButtonText.toUpperCase())),
              TextButton(
                  onPressed: onConfirmationPressed ??
                      () => Navigator.pop(context, true),
                  style: TextButton.styleFrom(
                      textStyle: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(fontSize: 14)),
                  child: Text(confirmationButtonText.toUpperCase())),
            ],
          );
        },
      ).then((value) => value);
    } else {
      return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: contentWidget ?? Text(contentText!),
            actions: <Widget>[
              if (cancelButtonText != null)
                CupertinoDialogAction(
                  onPressed:
                      onCancelPressed ?? () => Navigator.pop(context, false),
                  child: Text(cancelButtonText),
                ),
              CupertinoDialogAction(
                onPressed:
                    onConfirmationPressed ?? () => Navigator.pop(context, true),
                child: Text(confirmationButtonText),
              ),
            ],
          );
        },
      ).then((value) => value);
    }
  }
}
