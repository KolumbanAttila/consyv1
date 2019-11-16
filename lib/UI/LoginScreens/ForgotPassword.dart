import 'package:consyv1/Util/Auth.dart';
import 'package:consyv1/Util/InputValidator.dart';
import 'package:consyv1/Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';


class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
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
        hintText: 'E-mail',
        hintStyle: TextStyle(fontFamily: 'Esteban'),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final forgotPasswordButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          _forgotPassword(email: _email.text, context: context);
        },
        padding: EdgeInsets.all(12),
          color: Color(0xFFF2AB27),
        child: Text('Küldés', style: TextStyle(
            color: Colors.black,
            fontFamily: 'Esteban',
            fontSize: 20,
            fontWeight: FontWeight.bold)),
      ),
    );

    final signInLabel = FlatButton(
      child: Text(
        'Vissza a bejelentkezéshez',
        style: TextStyle(color: Colors.white,fontFamily: 'Esteban'),
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
                                  Text(
                                    'Add meg az e-mail címed!',
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
                              Container(
                                child: email,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                              ),
                              FractionalTranslation(
                                  translation: Offset(0, .5),
                                  child: Container(
                                    child: forgotPasswordButton,
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
                            child: Text(
                              'Vissza a bejelentkezéshez',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )),
                        SizedBox(
                          height: 80,
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

  void _forgotPassword({String email, BuildContext context}) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState.validate()) {
      try {
        await _changeLoadingVisible();
        await Auth.forgotPasswordEmail(email);
        await _changeLoadingVisible();
        Flushbar(
          title: "Jelszó helyreállitó:",
          message:
          'A jelszó helyreállitó linket elküldtük a következő e-mail címre: \n${_email.text}',
          duration: Duration(seconds: 20),
        )..show(context);
      } catch (e) {
        _changeLoadingVisible();
        print("Forgot Password Error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Rendszerhiba!",
          message: exception,
          duration: Duration(seconds: 7),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}