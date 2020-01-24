import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/Constants.dart';
import 'package:consyv1/Database.dart';
import 'package:consyv1/PoliceModel.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class PoliceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PoliceScreenState();
  }
}

class PoliceScreenState extends State<PoliceScreen> {
  List<String> bunnugyi = new List<String>();
  List<String> kozrendesz = new List<String>();

  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController imageURL = TextEditingController();

  Future<List<PoliceModel>> polices;

  var dbHelper;

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
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.green,
                    ),
                    Text('Add New Police'),
                  ],
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text(
                          "NEW POLICE DATA",
                          textAlign: TextAlign.center,
                        ),
                        content: ListView(
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              controller: name,
                              decoration: InputDecoration(hintText: 'NAME'),
                            ),
                            TextFormField(
                              controller: age,
                              decoration: InputDecoration(hintText: 'AGE'),
                            ),
                            TextFormField(
                              controller: gender,
                              decoration: InputDecoration(hintText: 'GENDER'),
                            ),
                            TextFormField(
                              controller: department,
                              decoration:
                                  InputDecoration(hintText: 'DEPARTMENT'),
                            ),
                            TextFormField(
                              controller: imageURL,
                              decoration:
                                  InputDecoration(hintText: 'FB IMAGE URL'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("SAVE"),
                            onPressed: () async {
                              await _save();
                              name.text = '';
                              age.text = '';
                              department.text = '';
                              imageURL.text = '';
                              gender.text = '';
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 25,),
              Expanded(
                child: FutureBuilder<List<PoliceModel>>(
                  future: DBProvider.db.getAllPolices(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PoliceModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          PoliceModel police = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text(
                                      "ARE U SURE U WANT TO DELETE?",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            new FlatButton(
                                              child: new Text("NEIN"),
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("YEAH"),
                                              onPressed: () async {
                                                await DBProvider.db.deletePolice(police.id);
                                                setState(() {

                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 80,
                                      height: 80,
                                      child: Image.network(
                                    police.image,fit: BoxFit.cover,
                                  )),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: <Widget>[
                                      Text(police.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                      Row(
                                        children: <Widget>[
                                          Text(police.age.toString()),
                                          Text(', '+police.gender),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 50,),
                                  Container(
                                    child:Flexible(child: Text(police.dep,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
                                    ,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }

  _save() async {
    PoliceModel policeModel = PoliceModel();
    policeModel.name = name.text;
    policeModel.age = int.parse(age.text);
    policeModel.gender = gender.text;
    policeModel.dep = department.text;
    policeModel.image = imageURL.text;

    DBProvider.db.newPolice(policeModel);
  }

  Future<dynamic> getAllPolices() {
    polices = DBProvider.db.getAllPolices();
    print(polices);
  }

  getDataBunugyi() {
    Firestore.instance
        .collection('users')
        .where('main_category', isEqualTo: 'police')
        .where('sub_category', isEqualTo: 'bunugyi')
        .snapshots()
        .listen((data) => bunnugyi.add(data.documents[1]['name']));
  }

  getDataKozrendesz() {
    Firestore.instance
        .collection('users')
        .where('main_category', isEqualTo: 'police')
        .where('sub_category', isEqualTo: 'kozrendesz')
        .snapshots()
        .listen((data) => kozrendesz.add(data.documents[0]['name']));
  }
}
