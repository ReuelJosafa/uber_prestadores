import 'package:flutter/cupertino.dart';

class CupertinoUtils {
  static void showModalDialog(BuildContext context, Widget child,
      {bool isDate = false}) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoTheme(
              data: CupertinoThemeData(
                  brightness: Brightness.light,
                  textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          TextStyle(fontSize: isDate ? 21 : null))),
              child: Container(
                height: 216,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ),
            ));
  }
}
