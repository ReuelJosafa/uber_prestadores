import 'package:flutter/material.dart';
import 'package:uber_prestadores/src/features/loading/loading_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber prestadores',
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LoadingPage(),
    );
  }
}

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: const Color(0xFF2B2E4D),
    textTheme: _textTheme(base.textTheme),
    primaryTextTheme: _textTheme(base.primaryTextTheme),
    scaffoldBackgroundColor: const Color(0xFFF7F7F7),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2B2E4D),
      secondary: Color(0xFFF7F7F7),
      tertiary: Color(0xFF4D22C5),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF3AA2D7),
      linearTrackColor: Color(0xFFC4C4C4),
    ),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xFF2B2E4D),
        titleTextStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: 'Poppins')),
    // toggleableActiveColor: const Color(0xFFD3A62A),
    splashColor: const Color(0xFFC4C4C4),
    buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF2B2E4D),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF2B2E4D),
          secondary: Color(0xFF3AA2D7),
        )),
  );
}

TextTheme _textTheme(TextTheme base) {
  return base
      .copyWith(
        caption:
            base.caption!.copyWith(fontSize: 12, fontWeight: FontWeight.w300),
        button:
            base.button!.copyWith(fontWeight: FontWeight.w700, fontSize: 18),
        headline1: base.headline1!.copyWith(
            fontSize: 30.0, fontWeight: FontWeight.w400, color: Colors.black),
        headline2: base.headline2!.copyWith(
            fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
        headline3: base.headline3!.copyWith(
            fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
        headline4: base.headline4!.copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
        headline5: base.headline5!.copyWith(
            fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black),
        headline6: base.headline5!.copyWith(
            fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black),
        bodyText1: base.bodyText1!.copyWith(
            fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black),
        bodyText2: base.bodyText2!.copyWith(
            fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.black),
        subtitle2: base.subtitle2!.copyWith(
            fontSize: 8.0, fontWeight: FontWeight.w400, color: Colors.black),
      )
      .apply(fontFamily: 'Poppins', bodyColor: const Color(0xFF000000));
}
