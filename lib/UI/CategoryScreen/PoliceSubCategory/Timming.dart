//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:consyv1/Constants.dart';
//import 'package:consyv1/UI/CategoryScreen/Police.dart';
//import 'package:flushbar/flushbar.dart';
//import 'package:flutter/material.dart';
//
//
//class Timming extends StatefulWidget{
//
//  String day;
//  String nev;
//
//
//  Timming(this.day,this.nev);
//
//  @override
//  State<StatefulWidget> createState() {
//    return TimmmigState();
//  }
//}
//
//class TimmmigState extends State<Timming>{
//  String tenEleven = '10-11';
//  var db = Firestore.instance;
//  bool isReserved =false;
//
//
//  @override
//  void initState() {
//    super.initState();
//    getCollection();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    double width = MediaQuery.of(context).size.width;
//    double height = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Color(0xFF9ABBD9),
//        title: Text(widget.day,style: TextStyle(color: Colors.black),),
//        centerTitle: true,
//      ),
//      body: ListView(
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  SizedBox(height: 30,),
//                  new Text("Időpontok",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
//                  SizedBox(height: 30,),
//                  Container(
//                    child: GestureDetector(
//                      onTap: () {
//                        showDialog(
//                          context: context,
//                          builder: (BuildContext context) {
//                            return AlertDialog(
//                              title: new Text("Foglalás"),
//                              content: new Text("Foglalod ezt az időpontot? $tenEleven"),
//                              actions: <Widget>[
//
//                                new FlatButton(
//                                  child: new Text("Nem"),
//                                  onPressed: () {
//                                    Navigator.of(context).pop();
//                                  },
//                                ),
//                                new FlatButton(
//                                  child: new Text("Igen"),
//                                  onPressed: () {
//                                    Constants.foglalas1nev = widget.nev;
//                                    Constants.foglalas1ora = '10-11';
//                                    Constants.foglalas1date = '2019/11/17';
//                                    reserveDate(tenEleven);
//                                    Navigator.of(context).pop();
//                                  },
//                                ),
//                              ],
//                            );
//                          },
//                        );
//                      },
//                      child: Card(
//                          color: isReserved?Colors.red:Color(0xFF98FB98),
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(20.0),
//                          ),
//                          child: Column(
//                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              Text('10-11',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                            ],
//                          )),
//                    ),
//                    width: width*0.9,
//                    height: 100,
//                  ),
//                  Container(
//                    child: Card(
//                        color: Color(0xFF98FB98),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: Column(
//                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text('11-12',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                          ],
//                        )),
//                    width: width*0.9,
//                    height: 100,
//                  ),
//                  Container(
//                    child: Card(
//                        color: Color(0xFF98FB98),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: Column(
//                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text('12-13',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                          ],
//                        )),
//                    width: width*0.9,
//                    height: 100,
//                  ),
//                  Container(
//                    child: Card(
//                        color: Color(0xFF98FB98),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: Column(
//                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text('13-14',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                          ],
//                        )),
//                    width: width*0.9,
//                    height: 100,
//                  ),
//                  Container(
//                    child: Card(
//                        color: Color(0xFF98FB98),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: Column(
//                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text('14-15',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                          ],
//                        )),
//                    width: width*0.9,
//                    height: 100,
//                  ),
//                  Container(
//                    child: Card(
//                      color: Color(0xFF98FB98),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20.0),
//                        ),
//                        child: Column(
//                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text('15-16',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//                          ],
//                        )),
//                    width: width*0.9,
//                    height: 100,
//                  ),
//                  SizedBox(height: 30,),
//                ],
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future <List<Map<dynamic, dynamic>>> getCollection() async{
//    List<DocumentSnapshot> templist;
//    List<Map<dynamic, dynamic>> list = new List();
//    CollectionReference collectionRef = Firestore.instance.collection("reserv");
//    QuerySnapshot collectionSnapshot = await collectionRef.getDocuments();
//
//    templist = collectionSnapshot.documents; // <--- ERROR
//
//    list = templist.map((DocumentSnapshot docSnapshot){
//      return docSnapshot.data;
//    }).toList();
//    print(list[2]["date"]);
//    return list;
////    if(list[0]["date"] == hour){
////
////    }
//  }
//
//  Future < void > reserveDate(String hour) async {
//    await db.collection('reserv').document(hour).collection(Constants.uID).add({
//      'general_uid':Constants.uID,
//      'service_id':Constants.uID,
//      'date':hour,
//      'accepted': 'pending'
//
//    }).then((documentReference) {
//      print(documentReference.documentID);
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => Police()),
//      );
//      Flushbar(
//        title: "SIKER",
//        message: 'A foglalását elküldtük, amely egy megerősítésre vár.',
//        duration: Duration(seconds: 3),
//      )..show(context);
//    }).catchError((e) {
//      print(e);
//    });
//  }
//}