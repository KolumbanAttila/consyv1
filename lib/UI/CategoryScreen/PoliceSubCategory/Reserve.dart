import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/UI/CategoryScreen/Police.dart';
import 'package:consyv1/UI/CategoryScreen/PoliceSubCategory/Kozrendesz.dart';
import 'package:consyv1/UI/CategoryScreen/PoliceSubCategory/Timming.dart';
import 'package:flutter/material.dart';

class Reserve extends StatefulWidget {
  String docuName;

  Reserve(this.docuName);

  @override
  State<StatefulWidget> createState() {
    return ReserveState();
  }
}

class ReserveState extends State<Reserve> {



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD2DAE2),
      appBar: AppBar(
        backgroundColor: Color(0xFF9ABBD9),
        title: Text(widget.docuName,style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios,color: Colors.black),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Police()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info,color: Colors.black,),onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Szükséges dokumentumok",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                  content: Container(
                    width: width*1,
                    height: 250,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('kozrendesz')
                          .where('name', isEqualTo: widget.docuName)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            return new ListView(
                              children:
                              snapshot.data.documents.map((DocumentSnapshot document) {
                                return Text(document["info"],textAlign: TextAlign.center,);
                              }).toList(),
                            );
                        }
                      },
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Értettem"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },)
        ],
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('kozrendesz')
            .where('name', isEqualTo: widget.docuName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return new ListView(
                children:
                snapshot.data.documents.map((DocumentSnapshot document) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 25,),
                      new Text("PROGRAM",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                      SizedBox(height: 25,),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Timming("Hétfő",widget.docuName)),
                            );
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Hétfő',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  Text(
                                    document["monday"],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        width: width*0.9,
                        height: 100,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Timming("Kedd",widget.docuName)),
                            );
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Kedd',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  Text(
                                    document["tuersday"],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        width: width*0.9,
                        height: 100,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Timming("Szerda",widget.docuName)),
                            );
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Szerda',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  Text(
                                    document["wednesday"],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        width: width*0.9,
                        height: 100,
                      ),
                      Container(
                        child:
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Timming("Csütörtök",widget.docuName)),
                            );
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Csütörtök',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                  Text(
                                    document["thursday"],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        width: width*0.9,
                        height: 100,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Timming("Péntek",widget.docuName)),
                            );
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Péntek',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                  Text(
                                    document["friday"],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                        width: width*0.9,
                        height: 100,
                      ),
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
