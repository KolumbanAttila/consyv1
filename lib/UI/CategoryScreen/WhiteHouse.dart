import 'package:consyv1/Constants.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:flutter/material.dart';


class WhiteHouse extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WhiteHouseState();
  }
}

class WhiteHouseState extends State<WhiteHouse>{
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD2DAE2),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.isHungary ? 'Fehérház' : 'Casă albă',
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
      body: Container(
        margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
        height: height * 1,
        child: new ListView.builder(
            physics: ScrollPhysics(),
            itemCount: Constants.isHungary
                ? Constants.whiteHouseListHU.length
                : Constants.whiteHouseListRO.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                margin: EdgeInsets.only(top: 25),
                height: 100,
                child: Card(
                  color: Color(0xFF9ABBD9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Constants.isHungary
                          ? Text(
                        Constants.whiteHouseListHU[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                          : Text(
                        Constants.whiteHouseListRO[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}