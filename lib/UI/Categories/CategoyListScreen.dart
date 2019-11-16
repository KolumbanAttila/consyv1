import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/Constants.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:consyv1/UI/SubCategoryCard.dart';
import 'package:flutter/material.dart';

class CategoryListScreen extends StatefulWidget {
  String title;

  CategoryListScreen(this.title);

  @override
  State<StatefulWidget> createState() {
    return CategoryListScreenState();
  }
}

class CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD2DAE2),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          langCategoryName(widget.title),
          style: TextStyle(
              fontFamily: 'Esteban', color: Colors.black, letterSpacing: 1.5),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainCategoryScreen()),
            );
          },
            child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        )),
        backgroundColor: Color(0xFF9ABBD9),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          PoliceSubCategory(),
        ],
      ),
    );
  }

  langCategoryName(String value) {
    if (value == "Fehérház") {
      return Constants.isHungary ? 'Fehérház' : 'Casă albă';
    }
    if (value == "Rendőrség") {
      return Constants.isHungary ? 'Rendőrség' : 'Poliție';
    }
    if (value == "Polgármesteri hivatal") {
      return Constants.isHungary ? 'Polgármesteri hivatal' : 'Primăria';
    }
    if (value == "Belügyminisztérium") {
      return Constants.isHungary ? 'Belügyminisztérium' : 'Ministerul afacerilor interne';
    }
    if (value == "Törvényszék") {
      return Constants.isHungary ? 'Törvényszék' : 'Tribunal';
    }
    if (value == "Román posta") {
      return Constants.isHungary ? 'Román posta' : 'Poşta Română';
    }
    if (value == "Magyarország Főkonzulátusa") {
      return Constants.isHungary ? 'Magyarország Főkonzulátusa' : 'Consulatul general al Ungariei';
    }
    if (value == "Börtön") {
      return Constants.isHungary ? 'Börtön' : 'Penitenciar';
    }
    if (value == "ANAF") {
      return Constants.isHungary ? 'ANAF' : 'ANAF';
    }
  }
}
