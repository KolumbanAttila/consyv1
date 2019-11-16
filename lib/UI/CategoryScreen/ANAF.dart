import 'package:consyv1/Constants.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:flutter/material.dart';


class ANAF extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ANAFState();
  }
}

class ANAFState extends State<ANAF>{
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD2DAE2),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.isHungary ? 'ANAF' : 'ANAF',
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
          child: Center(
            child: Text('ANAF'),
          )
      ),
    );
  }
}