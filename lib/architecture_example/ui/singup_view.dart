import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/singupmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email = "";
    String password = "";
    String usuario = "";
    String nombre = "";
    return BaseView<SingUpModel>(
        builder: (context, model, child) => Scaffold(
            body:
                // Provider.of<User>(context, listen: false).logged == true ?  CourseListView() :
                model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: Center(
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text("SingUp"),
                            ),
                            body: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        usuario = value;
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Username",
                                          icon: Icon(Icons.verified_user))),
                                  TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        nombre = value;
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Nombre",
                                          icon: Icon(Icons.person))),
                                  TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        email = value;
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Correo",
                                          icon: Icon(Icons.mail))),
                                  TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        password = value;
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: "Contraseña",
                                          icon: Icon(Icons.lock))),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Center(
                                      child: RaisedButton(
                                        onPressed: ()async {
                                          // Validate returns true if the form is valid, or false
                                          // otherwise.
                                          if (_formKey.currentState
                                              .validate()) {
                                            // If the form is valid, display a Snackbar.
                                                 var loginSuccess = await model
                                                .singUp(email, password,usuario,nombre);
                                            if (loginSuccess) {
                                              print(
                                                  'LoginView loginSuccess setting up setLoggedIn ');
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .setLoggedIn(
                                                      model.user.username,
                                                      model.user.token);
                                            }
                                          }
                                        },
                                        child: Text('SingUp'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
  }

  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
