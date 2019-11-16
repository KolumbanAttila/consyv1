import 'package:consyv1/Models/StateModel.dart';
import 'package:consyv1/UI/LoginScreens/SignInScreen.dart';
import 'package:consyv1/Util/StateWidget.dart';
import 'package:flutter/material.dart';


class MainCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainCategoryScreenState();
  }
}

class MainCategoryScreenState extends State<MainCategoryScreen> {
  bool _loadingVisible = false;
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Főoldal',
            style: TextStyle(
                fontFamily: 'Esteban', color: Colors.white, letterSpacing: 1.5),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  StateWidget.of(context).logOutUser();
                }),
          ],
        ),
        body: Center(
          child: Text('szia'),
        )
      );
    }
  }
}
