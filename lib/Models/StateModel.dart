import 'package:consyv1/Models/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserModel.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings
  });
}