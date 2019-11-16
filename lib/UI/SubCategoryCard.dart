import 'package:consyv1/Constants.dart';
import 'package:flutter/material.dart';

class PoliceSubCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PoliceSubCategoryState();
  }
}

class PoliceSubCategoryState extends State<PoliceSubCategory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
      height: height * 1,
      child: new ListView.builder(
          physics: ScrollPhysics(),
          itemCount: Constants.isHungary
              ? Constants.policeListHU.length
              : Constants.policeListRO.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
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
                            Constants.policeListHU[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        : Text(
                            Constants.policeListRO[index],
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
    );
  }
}
