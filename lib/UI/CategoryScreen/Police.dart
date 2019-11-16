import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/Constants.dart';
import 'package:consyv1/UI/CategoryScreen/PoliceSubCategory/Bunugyi.dart';
import 'package:consyv1/UI/CategoryScreen/PoliceSubCategory/Kozrendesz.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:flutter/material.dart';


class Police extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PoliceState();
  }
}

class PoliceState extends State<Police>{
  List<String> bunnugyi = new List<String>();
  List<String> kozrendesz = new List<String>();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD2DAE2),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.isHungary ? 'Rendőrség' : 'Poliție',
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 25,),
            GestureDetector(
              onTap: () async {
                await getDataBunugyi();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bunugyi(bunnugyi)),
                );
              print(bunnugyi.length);
              },
              child: Container(
                width: width*1,
                height: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Bűnügyi',textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () async {
                await getDataKozrendesz();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Kozrendesz(kozrendesz)),
                );
                print(kozrendesz.length);
              },
              child: Container(
                width: width*1,
                height: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Közrendész',textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
  getDataBunugyi() {
      Firestore.instance.collection('users').where(
          'main_category', isEqualTo: 'police').where(
          'sub_category', isEqualTo: 'bunugyi')
          .snapshots().listen(
              (data) => bunnugyi.add(data.documents[1]['name'])
      );

  }
  getDataKozrendesz() {
    Firestore.instance.collection('users').where(
        'main_category', isEqualTo: 'police').where(
        'sub_category', isEqualTo: 'kozrendesz')
        .snapshots().listen(
            (data) => kozrendesz.add(data.documents[0]['name'])
    );
  }
}