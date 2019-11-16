import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Reserve extends StatefulWidget{
  String docuName;


  Reserve(this.docuName);

  @override
  State<StatefulWidget> createState() {
    return ReserveState();
  }
}

class ReserveState extends State<Reserve>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('kozrendesz').where('name',isEqualTo: widget.docuName).snapshots(),
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
                      Container(child: Card(child: Text(document["monday"],textAlign: TextAlign.center,)),width:400,height: 50,),
                      Container(child: Card(child: Text(document["tuersday"],textAlign: TextAlign.center,)),width:400,height: 50,),
                      Container(child: Card(child: Text(document["wednesday"],textAlign: TextAlign.center,)),width:400,height: 50,),
                      Container(child: Card(child: Text(document["thursday"],textAlign: TextAlign.center,)),width:400,height: 50,),
                      Container(child: Card(child: Text(document["friday"],textAlign: TextAlign.center,)),width:400,height: 50,),
                    ],
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}