import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:uber_prestadores/src/features/approvals_history/approvals_history_page.dart';
import 'package:uber_prestadores/src/features/auth/auth_page.dart';
import 'package:uber_prestadores/src/features/home/home_page.dart';
import 'package:uber_prestadores/src/features/loading/loading_page.dart';
import 'package:uber_prestadores/src/features/password_recovery/password_recovery_page.dart';
import 'package:uber_prestadores/src/features/scheduled_rides/scheduled_rides_page.dart';
import 'package:uber_prestadores/src/features/search_user/search_user_page.dart';
import 'package:uber_prestadores/src/shared/constants/app_routes.dart';
import 'package:uber_prestadores/src/shared/controllers/map_location_controller.dart';
import 'package:uber_prestadores/src/shared/repositories/client_http.dart';
import 'package:uber_prestadores/src/shared/repositories/location_repository.dart';
import 'package:uber_prestadores/src/shared/repositories/map_location_repository.dart';

import 'features/password_recovery_success/password_recovery_success_page.dart';
import 'features/password_selection/password_selection_page.dart';
import 'features/schedule_ride_confirmation/schedule_ride_confirmation_page.dart';
import 'shared/controllers/search_place_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => MapLocationRepository()),
        Provider(create: (_) => ClientHttp()),
        Provider(
            create: (context) =>
                LocationRepository(context.read<ClientHttp>())),
        ChangeNotifierProvider(
            create: (context) => MapLocationController(
                  context.read<MapLocationRepository>(),
                  context.read<LocationRepository>(),
                )),
        ChangeNotifierProvider(
            create: (context) =>
                SearchPlaceController(context.read<LocationRepository>()))
      ],
      child: MaterialApp(
        title: 'Uber prestadores',
        theme: _buildTheme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        routes: {
          AppRoutes.loading: (context) => const LoadingPage(),
          AppRoutes.auth: (context) => const AuthPage(),
          AppRoutes.forgetPassword: (context) => const PasswordRecoveryPage(),
          AppRoutes.selectPassword: (context) => const PasswordSelectionPage(),
          AppRoutes.passwordRecovered: (context) =>
              const PasswordRecoverySuccessPage(),
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.scheduleRideConfirmation: (context) =>
              const ScheduleRideConfirmationPage(),
          AppRoutes.approvalsHistory: (context) => const ApprovalsHistoryPage(),
          AppRoutes.scheduledRides: (context) => const ScheduledRidesPage(),
          AppRoutes.searchUser: (context) => const SearchUser(),
        },
        // home: const LoadingPage(),
      ),
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
    dialogTheme: DialogTheme(
      titleTextStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black.withOpacity(0.6),
      ),
    ),
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
