import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';



User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String userId;
  String name;
  String email;
  String location;
  String userType;
  String regDate;

  User({
    this.userId,
    this.name,
    this.email,
    this.location,
    this.regDate,
    this.userType
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    location: json["location"],
    regDate: json["reg_date"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "location":location,
    "reg_date":regDate,
    "user_type":userType,
  };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}