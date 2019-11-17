import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/UI/MainCategoryScreen.dart';
import 'package:consyv1/Widgets/MyVisibility.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';


class AddService extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddServiceState();
  }
}

class AddServiceState extends State<AddService>{

  var db = Firestore.instance;
  TextEditingController info = new TextEditingController();
  TextEditingController m = new TextEditingController();
  TextEditingController t = new TextEditingController();
  TextEditingController w = new TextEditingController();
  TextEditingController th = new TextEditingController();
  TextEditingController f = new TextEditingController();
  List<String> _service = ['Rendőrség', 'Fehérház', 'Polgármesteri hivatal', 'Törvényszék'];
  TextEditingController _phone = TextEditingController();
  String _finalService;
  String _value;
  bool bunugy = false;
  bool kozrend = true;
  bool wedVal = false;
  bool isPolice = false;
  String subCat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 50,),
            Text('Telefonszám: '),
            TextField(
                controller: _phone,
                keyboardType: TextInputType.number
            ),
            SizedBox(height: 50,),
            Text('Infók: '),
            TextField(
              controller: info,
            ),
            SizedBox(height: 50,),
            Text('Fogadóórá'),
            Text('Hétfő'),
            TextField(
              keyboardType: TextInputType.number,
              controller: m,
            ),
            SizedBox(height: 25,),
            Text('Kedd'),
            TextField(
              keyboardType: TextInputType.number,
              controller: t,
            ),
            SizedBox(height: 25,),
            Text('Szerda'),
            TextField(
              keyboardType: TextInputType.number,
              controller: w,
            ),
            SizedBox(height: 25,),
            Text('Csütörtök'),
            TextField(
              keyboardType: TextInputType.number,
              controller: th,
            ),
            SizedBox(height: 25,),
            Text('Péntek'),
            TextField(
              keyboardType: TextInputType.number,
              controller: f,
            ),
            SizedBox(height: 25,),
            Text('Kategória'),
            DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  child: Row(
                    children: <Widget>[
                      Text('Rendőrség'),
                    ],
                  ),
                  value: 'one',
                ),
                DropdownMenuItem<String>(
                  child: Row(
                    children: <Widget>[
                      Text('Fehérház'),
                    ],
                  ),
                  value: 'two',
                ),
                DropdownMenuItem<String>(
                  child: Row(
                    children: <Widget>[
                      Text('Polgármesteri hivatal'),
                    ],
                  ),
                  value: 'three',
                ),
              ],
              isExpanded: false,
              onChanged: (String value) {
                setState(() {
                  _finalService =value;
                  _value = value;
                });
              },
              hint: Text(''),
              value: _value,
              underline: Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))
                ),
              ),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            MyVisibility(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Bűnügy"),
                      Checkbox(
                        value: bunugy,
                        onChanged: (bool value) {
                          kozrend =!kozrend;
                          setState(() {
                            bunugy = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Közrendészet"),
                      Checkbox(
                        value: kozrend,
                        onChanged: (bool value) {
                          bunugy =!bunugy;
                          setState(() {
                            kozrend = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              visibility: _finalService == 'one'?VisibilityFlag.visible:VisibilityFlag.invisible,
            ),
            RaisedButton(
              onPressed: () async {

                if(_finalService == 'one'){
                  _finalService = 'Rendőrség';
                }
                if(_finalService == 'two'){
                  _finalService = 'Fehérház';
                }
                if(_finalService == 'three'){
                  _finalService = 'Polgármesteri hivatal';
                }
                if(!bunugy){
                  subCat = "kozrendesz";
                }else{
                  subCat = "bunugy";
                }
                await addService();
                await _updateData();
                print(_finalService);
              },
              child: Text('Mentés'),
            )
          ],
        ),
      ),
    );
  }
  Future < void > addService() async {
    await db.collection(subCat).add({
      'name':Constants.uName,
      'work_phone': _phone.text,
      'info':info.text,
      'monday':m.text,
      'tuersday':t.text,
      'wednesday':w.text,
      'thursday':th.text,
      'friday':f.text,
      'service':_finalService,
      'serviceSubCat': subCat,
    }).then((documentReference) {
      print(documentReference.documentID);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainCategoryScreen()),
      );
      Flushbar(
        title: "SIKER",
        message: 'Szolgáltatás hozzáadva',
        duration: Duration(seconds: 3),
      )..show(context);
    }).catchError((e) {
      print(e);
    });
  }
  _updateData() async {
    await db
        .collection('users').document(Constants.uID).updateData({
          'user_type':'service'
    });
  }
}