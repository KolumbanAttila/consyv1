import 'package:consyv1/Constants.dart';
import 'package:consyv1/Localization/app_translations_delegate.dart';
import 'package:consyv1/Localization/application.dart';
import 'package:consyv1/Models/StateModel.dart';
import 'package:consyv1/UI/LoginScreens/ForgotPassword.dart';
import 'package:consyv1/UI/LoginScreens/SignInScreen.dart';
import 'package:consyv1/UI/LoginScreens/SignUpScreen.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:consyv1/UI/ThemeTest.dart';
import 'package:consyv1/Util/StateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';





class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consy',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MainCategoryScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
      },
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("hu", ""),
        const Locale("ro", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}


void main() {
  StateWidget stateWidget = new StateWidget(
    child: new LocalisedApp(),
  );
  runApp(stateWidget);
}

