import 'package:consyv1/Constants.dart';
import 'package:flutter/material.dart';



class MyReservs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyReservsState();
  }
}

class MyReservsState extends State<MyReservs>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foglalásaim',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Color(0xFF9ABBD9),
      ),
      body: ListView(
        children: <Widget>[
          Constants.foglalas1nev==null?Text(''):Card(
              color: Color(0xFF9ABBD9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Közrendészet",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black),),
                  SizedBox(height: 25,),
                  Text(Constants.foglalas1nev,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),

                  Text('Dátum: '+Constants.foglalas1date,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                  Text(
                    'Időpont: '+Constants.foglalas1ora,
                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
                  ),
                ],
              )),
          Card(
              color: Color(0xFF9ABBD9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Családorvos',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black),),
                  SizedBox(height: 25,),
                  Text('Dr. Nagy István',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),

                  Text('Dátum: 2019/11/28',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                  Text(
                    'Időpont: 18-19',
                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
                  ),
                ],
              )),
          Card(
              color: Color(0xFF9ABBD9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Kataszteri hivatal',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black),),
                  SizedBox(height: 25,),
                  Text('Dr. Sima Mihai',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),

                  Text('Dátum: 2019/12/12',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                  Text(
                    'Időpont: 8-9',
                    textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
                  ),
                ],
              )),
        ],
      ),
    );
  }

}