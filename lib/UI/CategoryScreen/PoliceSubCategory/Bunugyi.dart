import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/UI/CategoryScreen/Police.dart';
import 'package:flutter/material.dart';

import '../../../Constants.dart';

class Bunugyi extends StatefulWidget {
  List<String> elements = new List<String>();

  Bunugyi(this.elements);

  @override
  State<StatefulWidget> createState() {
    return BunugyiState();
  }
}

class BunugyiState extends State<Bunugyi> {
  String name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xFFD2DAE2),
        appBar: AppBar(
          backgroundColor: Color(0xFF9ABBD9),
          title: Text("Bűnügyi",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios,color: Colors.black),
            onTap: () {
              widget.elements.clear();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Police()),
              );
            },
          ),
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('bunugyi').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Container(
                            width: width*0.9,
                            height: 50,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(document["name"],textAlign: TextAlign.center,),
                                  ],
                                ))),
                          ),
                        ],
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ),
    );
  }

  loadData() {
    for (var i in widget.elements) {
      name = i;
      print(name);
      return name;
    }
  }
}
