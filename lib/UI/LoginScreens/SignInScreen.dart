import 'package:consyv1/Constants.dart';
import 'package:consyv1/Util/Auth.dart';
import 'package:consyv1/Util/InputValidator.dart';
import 'package:consyv1/Util/StateWidget.dart';
import 'package:consyv1/Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();



  bool _autoValidate = false;
  bool _loadingVisible = false;
  bool hidePassword=true;
  bool isHungary = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _email,
      validator: Validator.validateEmail,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
        hintText: 'Email',
        hintStyle: TextStyle(fontFamily: 'Esteban'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: hidePassword,
      controller: _password,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: () {hidePassword=!hidePassword;
        setState(() {

        });},),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        hintText: Constants.isHungary?'Jelszó':'Parola',
        hintStyle: TextStyle(fontFamily: 'Esteban'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _emailLogin(
              email: _email.text, password: _password.text, context: context);
        },
        padding: EdgeInsets.all(12),
        color:  Color(0xFFF2AB27),
        child: Constants.isHungary?Text('Bejelentkezés', style: TextStyle(
            color: Colors.black,
            fontFamily: 'Esteban',
            fontSize: 20,
            fontWeight: FontWeight.bold),):Text('Autentificare', style: TextStyle(
          color: Colors.black,
          fontFamily: 'Esteban',
      fontSize: 20,
      fontWeight: FontWeight.bold),),
      ),
    );



    return Scaffold(
      backgroundColor: Color(0xFFc2d1ca),
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              children: <Widget>[
                Container(
                  height: height * 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background/background.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.35), BlendMode.dstATop),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: width * 0.27,
                                decoration: BoxDecoration(
                                    color: Color(0xFFE9E9E9),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                height: 116,
                                child: Image.asset('assets/logo.png'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 140,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Color(0xFF9ABBD9).withOpacity(0.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Constants.isHungary?Text(
                                    'Bejelentkezés',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ):Text(
                                    'Autentificare',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (Constants.isHungary == true){
                                    Constants.isHungary = !Constants.isHungary;
                                    setState(() {
                                      print(Constants.isHungary);
                                    });}
                                },
                                child: Row(
                                  children: <Widget>[
                                    Constants.isHungary
                                        ? Text(
                                      'RO',
                                      style: TextStyle(fontSize: 18, color: Colors.black),
                                    )
                                        : Text(
                                      'RO',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
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
                                  if (!Constants.isHungary){
                                    Constants.isHungary = !Constants.isHungary;
                                    setState(() {
                                      print(Constants.isHungary);
                                    });}
                                },
                                child: Row(
                                  children: <Widget>[
                                    Constants.isHungary
                                        ? Text(
                                      'HU',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                        : Text(
                                      'HU',
                                      style: TextStyle(fontSize: 18, color: Colors.black),
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
                                height: 25,
                              ),

                              Container(
                                child: email,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                child: password,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              FractionalTranslation(
                                  translation: Offset(0, .5),
                                  child: Container(
                                    child: loginButton,
                                    width: width * 0.54,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        GestureDetector(
                            onTap: () {Navigator.pushNamed(context, '/forgot-password');},
                            child: Constants.isHungary?Text(
                              'Elfelejtetted a jelszavad?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ):Text(
                              'Ai uitat parola?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {Navigator.pushNamed(context, '/signup');},
                            child: Constants.isHungary?Text(
                              'Még nincs fiókom! Regisztrálok!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ):Text(
                              'Nu ai cont? Poti crea unul in pasul urmator.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        print('========================================================='+email);
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        await StateWidget.of(context).logInUser(email, password);
        await Navigator.pushNamed(context, '/');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign In Error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "ERROR",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }


}