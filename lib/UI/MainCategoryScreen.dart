import 'package:consyv1/Constants.dart';
import 'package:consyv1/Models/StateModel.dart';
import 'package:consyv1/UI/LoginScreens/SignInScreen.dart';
import 'package:consyv1/Util/StateWidget.dart';
import 'package:flutter/material.dart';

class MainCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainCategoryScreenState();
  }
}

class MainCategoryScreenState extends State<MainCategoryScreen> {
  bool _loadingVisible = false;
  StateModel appState;

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (!appState.isLoading &&
        (appState.firebaseUserAuth == null ||
            appState.user == null ||
            appState.settings == null)) {
      return SignInScreen();
    } else {
      if (appState.isLoading) {
        _loadingVisible = true;
      } else {
        _loadingVisible = false;
      }
      return Scaffold(
          backgroundColor: Color(0xFFD2DAE2),
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Color(0xFF9ABBD9),
            centerTitle: true,
            title: Text(
              Constants.isHungary ? 'Csíkszereda' : 'Miercurea Ciuc',
              style: TextStyle(
                  fontFamily: 'Esteban',
                  color: Colors.black,
                  letterSpacing: 1.5),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () {
                    StateWidget.of(context).logOutUser();
                  }),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF9ABBD9)),
                  accountName: Text(
                    'Dr. Trimfa Egon',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      "T",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.black,
                    size: 30,
                  ),
                  title: Constants.isHungary
                      ? Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Profilul',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),
                  title: Constants.isHungary?Text(
                    'Beállitások',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ):Text(
                    'Setări',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.timeline,
                    color: Colors.black,
                    size: 30,
                  ),
                  title: Constants.isHungary?Text(
                    'Foglalásaim',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ):Text(
                    'Rezervare',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  title: Constants.isHungary?Text(
                    'Kereső',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ):Text(
                    'Căutare',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (Constants.isHungary == true) {
                          Constants.isHungary = !Constants.isHungary;
                          setState(() {
                            print(Constants.isHungary);
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Constants.isHungary
                              ? Text(
                                  'RO',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )
                              : Text(
                                  'RO',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF9ABBD9),
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(
                            width: 3,
                          ),
                          Image.asset(
                            'assets/lang/romania.png',
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text('|'),
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!Constants.isHungary) {
                          Constants.isHungary = !Constants.isHungary;
                          setState(() {
                            print(Constants.isHungary);
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Constants.isHungary
                              ? Text(
                                  'HU',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF9ABBD9),
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  'HU',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                          SizedBox(
                            width: 3,
                          ),
                          Image.asset(
                            'assets/lang/hungary.png',
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 250,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('assets/logo.png',width: 50,height: 50,),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      elevation: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 155,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/cards/rendorseg.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Constants.isHungary
                                ? Text(
                                    'Rendőrség',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 22),
                                  )
                                : Text(
                                    'Poliție',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 22),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 155,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/cards/polgarmesterihivatal.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.35),
                                  BlendMode.dstATop),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Constants.isHungary?Text(
                                'Polgármesteri hivatal',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),textAlign: TextAlign.center,
                              )
                                  : Text(
                                'Primăria',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 155,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/cards/tanacs.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.dstATop),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Constants.isHungary
                            ? Text(
                          'Tanács',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22),
                        )
                            : Text(
                          'Consiliul',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      elevation: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 155,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/cards/torvenyszek.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Constants.isHungary
                                ? Text(
                              'Törvényszék',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22),
                            )
                                : Text(
                              'Tribunal',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 155,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/cards/posta.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.35),
                                  BlendMode.dstATop),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Constants.isHungary?Text(
                                'Román posta',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),textAlign: TextAlign.center,
                              )
                                  : Text(
                                'Poşta Română',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    height: 155,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: AssetImage('assets/cards/tanacs.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.dstATop),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Constants.isHungary
                            ? Text(
                          'Tanács',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22),
                        )
                            : Text(
                          'Consiliul',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    }
  }
}
