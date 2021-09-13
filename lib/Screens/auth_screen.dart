import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Models/http_exceptios.dart';
import 'package:shopapp/Providers/auth.dart';

class AuthScreen extends StatelessWidget {
  static const authscreen_routename = "/auth-screen";

  @override
  Widget build(BuildContext context) {
    final phone_size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(215, 117, 255, 1),
            Color.fromRGBO(225, 118, 117, 1),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        SingleChildScrollView(
          child: Container(
            width: phone_size.width,
            height: phone_size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade400,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 1,
                              offset: Offset(10, 7))
                        ]),
                    margin: EdgeInsets.only(bottom: 15),
                    transform: Matrix4.rotationZ(-11 * pi / 180)
                      ..translate(-10.00),
                    child: Text(
                      "Shop App ",
                      style: TextStyle(
                          fontFamily: "Anton",
                          fontSize: 50,
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline1
                              .color),
                    ),
                  ),
                ),
                Flexible(
                    flex: phone_size.width > 600 ? 2 : 1, child: AuthCard()),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

enum Authmode { login, signup }

class _AuthCardState extends State<AuthCard> {
  final _formkey = GlobalKey<FormState>();
  Authmode _authmode = Authmode.login;
  TextEditingController _textEditingController_password =
      TextEditingController();
  Map<String, String> _authdata = {
    "email": "",
    "password": "",
  };
  bool _isloding = false;
  Future<void> _submit() async {
    // Focus.of(context).unfocus();
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      setState(() {
        _isloding = true;
      });
    }

    try {
      if (_authmode == Authmode.login) {
        await Provider.of<Auth>(context, listen: false)
            .authLogin(_authdata["email"], _authdata["password"]);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .authSignup(_authdata["email"], _authdata["password"]);
      }
    } on HttpException catch (errors) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(errors.toString()),
        backgroundColor: Colors.black26,

//         Theme.of(ctx).splashColor,
      ));
      // Fluttertoast.showToast(
      //     msg: "safmknlkdsfsakdl;fm;lsdkmfl;sd",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      print(" this is eror in exception $errors");
    } catch (eror) {
      Fluttertoast.showToast(
          msg: eror,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print(" this is eror in second $eror");
    }

    setState(() {
      _isloding = false;
    });
  }

  _switchAuthMode() {
    if (_authmode == Authmode.login) {
      setState(() {
        _authmode = Authmode.signup;
      });
    } else {
      if (_authmode == Authmode.signup) {
        setState(() {
          _authmode = Authmode.login;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onSaved: (value) {
                  _authdata["email"] = value;
                },
                validator: (val) {
                  if (val.isEmpty || !val.contains("@")) {
                    return "please Enter a valid Email ";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: " Email Adress ",
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                onSaved: (value) {
                  _authdata["password"] = value;
                },
                validator: (val) {
                  if (val.isEmpty || val.length < 7) {
                    return "please Enter a valid password more than 7 ";
                  }
                  return null;
                },
                controller: _textEditingController_password,
                decoration: InputDecoration(
                    hintText: " password ",
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              if (_authmode == Authmode.signup)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    obscureText: true,
                    validator: (val) {
                      if (val.isEmpty ||
                          val != _textEditingController_password.text) {
                        return "password dont match ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: " Reapeat Password ",
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        )),
                  ),
                ),
              if (_isloding)
                CircularProgressIndicator(
                  color: Colors.teal.shade600,
                ),
              if (!_isloding)
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    color: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: _submit,
                    child: Text(
                      _authmode == Authmode.login ? "Login" : "Sign Up",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              if (!_isloding)
                FlatButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _authmode == Authmode.login
                          ? " Create an account"
                          : "i have an account",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black45,
                          fontFamily: "Lato"
                          // Theme.of(context).accentTextTheme.headline3.color

                          ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
