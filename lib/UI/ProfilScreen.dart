import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consyv1/Constants.dart';
import 'package:consyv1/UI/AddService.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  var db = Firestore.instance;
 TextEditingController info = new TextEditingController();
 TextEditingController m = new TextEditingController();
 TextEditingController t = new TextEditingController();
 TextEditingController w = new TextEditingController();
 TextEditingController th = new TextEditingController();
 TextEditingController f = new TextEditingController();
  List<String> _service = ['Rendőrség', 'Fehérház', 'Polgármesteri hivatal', 'Törvényszék'];
 TextEditingController _phone = TextEditingController();
  String _selectedLocation;
  String _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profil',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Color(0xFF9ABBD9),
        ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Név:'),
                SizedBox(width: 25,),
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(Constants.uID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      return new Text(userDocument["name"]);
                    }),
              ],
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Szolgáltatás regisztrálása'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddService()),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
        );
  }
  Future < void > addStudent() async {
    await db.collection("bunugyi").add({
      'work_phone': _phone.text,
    }).then((documentReference) {
      print(documentReference.documentID);
    }).catchError((e) {
      print(e);
    });
  }
}
