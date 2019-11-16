import 'package:consyv1/Constants.dart';
import 'package:consyv1/Models/StateModel.dart';
import 'package:consyv1/UI/LoginScreens/ForgotPassword.dart';
import 'package:consyv1/UI/LoginScreens/SignInScreen.dart';
import 'package:consyv1/UI/LoginScreens/SignUpScreen.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:consyv1/UI/ThemeTest.dart';
import 'package:consyv1/Util/StateWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Consy extends StatelessWidget {

  StateModel appState;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    Constants.uID = appState?.firebaseUserAuth?.uid ?? '';
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
    );
  }
}

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new Consy(),
  );
  runApp(stateWidget);
}