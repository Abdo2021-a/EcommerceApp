import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopapp/Models/http_exceptios.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userid;
  DateTime _expiredate;
  Timer _authtimer;
  bool get isauth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiredate.isAfter(DateTime.now()) &&
        _expiredate != null) {
      return _token;
    }
  }

  String get userid {
    return _userid;
  }

  Future<void> authLogin(String email, String password) async {
    const urllogin =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCzdU0ADhCQQaCiuVCTfefoDZDSrCKYoqA";
    try {
      var response = await http.post(
          Uri.parse(
            urllogin,
          ),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      var resposedata = json.decode(response.body);
      print("  response of auth   $resposedata");
      if (resposedata["error"] != null) {
        throw HttpException(resposedata["error"]["message"]);
      }
      _token = resposedata["idToken"];
      _userid = resposedata["localId"];
      _expiredate = DateTime.now()
          .add(Duration(seconds: int.parse(resposedata["expiresIn"])));
      autoLogOut();
      notifyListeners();
      var prefs = await SharedPreferences.getInstance();
      var userdata = json.encode({
        "token": _token,
        "userid": _userid,
        "expiredate": _expiredate.toIso8601String(),
      });
      prefs.setString("userdata", userdata);
    } catch (eror) {
      throw eror;
    }
  }

  Future<void> authSignup(String email, String password) async {
    const urllogin =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCzdU0ADhCQQaCiuVCTfefoDZDSrCKYoqA";
    try {
      var response = await http.post(
          Uri.parse(
            urllogin,
          ),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      var resposedata = json.decode(response.body);
      print("  response of auth   $resposedata");
      if (resposedata["error"] != null) {
        throw HttpException(resposedata["error"]["message"]);
      }
      _token = resposedata["idToken"];
      _userid = resposedata["localId"];
      _expiredate = DateTime.now()
          .add(Duration(seconds: int.parse(resposedata["expiresIn"])));
      autoLogOut();
      notifyListeners();
      var prefs = await SharedPreferences.getInstance();
      var userdata = json.encode({
        "token": _token,
        "userid": _userid,
        "expiredate": _expiredate.toIso8601String(),
      });
      prefs.setString("userdata", userdata);
    } catch (eror) {
      throw eror;
    }
  }

  Future<void> logOut() async {
    _expiredate = null;
    _token = null;
    _userid = null;
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();

    prefs.clear();
    print("    token $_token");
    print("  expire date $_expiredate");
    ;
    print("   user id$_userid");
    ;
    print("prefs    $prefs");
    ;
  }

  autoLogOut() {
    final expiretime = _expiredate.difference(DateTime.now()).inSeconds;
    _authtimer = Timer(Duration(seconds: expiretime), logOut);
    return _authtimer;
    // review it
  }

  Future<bool> autoLogIn() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userdata")) return false;

    final storeduserdata = json.decode(prefs.getString("userdata"));
    var expiredtimestored = DateTime.parse(storeduserdata["expiredate"]);
    if (expiredtimestored.isBefore(DateTime.now())) return false;
    _token = storeduserdata['token'];
    _userid = storeduserdata['userid'];
    _expiredate = expiredtimestored;
    notifyListeners();
    autoLogOut();
    return true;
  }
}
