import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _read();
  }
  String _username;
  String _token;
  String _email="";
  String _password="";
  bool _remember= false;
  bool _loggedIn = false;
  bool _userCreated = false;

  get remember => _remember;
  get username => _username;
  get userCreated => _userCreated;
  get loggedIn => _loggedIn;
  get token => _token;
  get email => _email;
  get password => _password;


  void setLoggedIn(String userName, String token,String email,String password) {
    
    _username = userName;
    _loggedIn = true;
    _token = token;
    _password=password;
    _email=email;
    _save();
    notifyListeners();
  }
  setRemember(bool value) {
    _remember = value;
   
        _save();
    notifyListeners();
  }

  void setLogOut() {
    _loggedIn = false;
    _save();
    notifyListeners();
  }

  void setUserCreated(bool state) {
    _userCreated = state;
    notifyListeners();
  }

 void _read() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getBool('my_int_key') ?? false;
    final e = prefs.getString('email') ?? "Nada";
    final t = prefs.getString('my_token') ?? "_";
    final x = prefs.getString('my_username') ?? "_";
    final p = prefs.getString('password') ?? "Nada";
    final r = prefs.getBool('remember')??false;
    if (v != null) {
      _loggedIn = v;
      _token = t;
      _username = x;
      _remember=r;
      _email=e;
      _password=p;
      notifyListeners();
    }
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
      prefs.setBool("remember", _remember);
    prefs.setBool('my_int_key', _loggedIn);
    prefs.setString('my_token', _token);
    prefs.setString('my_username', _username);
    prefs.setString('password', _password);
    prefs.setString('email', _email);
  }
}

