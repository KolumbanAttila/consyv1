import 'package:consyv1/Constants.dart';
import 'package:consyv1/Models/UserModel.dart';
import 'package:consyv1/Util/Auth.dart';
import 'package:consyv1/Util/InputValidator.dart';
import 'package:consyv1/Widgets/Loading.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _location = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _passwordVal = new TextEditingController();
  bool hidePassword = true;
  bool hidePasswordVal = true;
  bool _autoValidate = false;
  bool _loadingVisible = false;
  bool isChecked = false;
  bool isHungary = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final name = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _name,
      validator: Validator.validateName,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
        hintText: Constants.isHungary?'Teljes név':'Nume și Prenume',
        hintStyle: TextStyle(fontFamily: 'Esteban'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final location = TextFormField(
      autofocus: false,
      textCapitalization: TextCapitalization.words,
      controller: _location,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.location_city,
            color: Colors.grey,
          ),
        ),
        hintText: Constants.isHungary?'Lakhely':'Reședință',
        hintStyle: TextStyle(fontFamily: 'Esteban'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

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
        hintText: 'E-mail',
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
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            hidePassword = !hidePassword;
            setState(() {});
          },
        ),
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

    final passwordValidation = TextFormField(
      autofocus: false,
      obscureText: hidePasswordVal,
      controller: _passwordVal,
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFE9E9E9),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: () {
            hidePasswordVal = !hidePasswordVal;
            setState(() {});
          },
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        hintText: Constants.isHungary?'Jelszó':'Verificare parola',
        hintStyle: TextStyle(fontFamily: 'Esteban'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        color: Color(0xFFF2AB27),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_password.text == _passwordVal.text && isChecked ) {
            _emailSignUp(
                name: _name.text,
                email: _email.text,
                password: _password.text,
                location: _location.text,
                context: context);
          } else {
            Flushbar(
              title: "ERROR!",
              message: Constants.isHungary?"A jelszó nem egyezik!":'Parola nu se potrivește!',
              duration: Duration(seconds: 5),
            )..show(context);
          }
        },
        padding: EdgeInsets.all(12),
        child:Constants.isHungary? Text('Regisztráció',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Esteban',
                fontSize: 20,
                fontWeight: FontWeight.bold)):Text('Înregistrare',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Esteban',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
    );

    final signInLabel = FlatButton(
      child: Text(
        'Vissza a bejelentkezéshez',
        style: TextStyle(color: Colors.black54, fontFamily: 'Esteban'),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
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
                          height: 100,
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
                                 Constants.isHungary? Text(
                                    'Regisztráció',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ):
                                 Text(
                                   'Înregistrare',
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
                                child: name,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32))),
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
                                child: location,
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
                              Container(
                                child: passwordValidation,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: isChecked
                                          ? Icon(
                                              Icons.radio_button_checked,
                                              color: Color(0xFFF2AB27),
                                              size: 25,
                                            )
                                          : Icon(
                                              Icons.radio_button_unchecked,
                                              size: 25,
                                            ),
                                      onTap: () {
                                        isChecked = !isChecked;
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Constants.isHungary?
                                    Text(
                                      'Elfogadom a felhasználási feltételeket',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ):
                                    Text(
                                      'Accept termenii și condițiile generale',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              FractionalTranslation(
                                  translation: Offset(0, .5),
                                  child: Container(
                                    child: signUpButton,
                                    width: width * 0.54,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () {Navigator.pushNamed(context, '/signin');},
                            child: Constants.isHungary?Text(
                          'Vissza a bejelentkezéshez',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ):Text(
                              'Înapoi la autentificare',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )),
                        SizedBox(
                          height: 350,
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

  void _emailSignUp(
      {String name,
      String email,
      String location,
      String password,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((uID) {
          Auth.addUserSettingsDB(new User(
              userId: uID, email: email, name: name, location: location));
        });
        await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "ERROR!",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
