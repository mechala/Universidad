import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/loginmodel.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/singup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember =  false;

  @override
  Widget build(BuildContext context) {
    
      remember=Provider.of<AuthProvider>(context, listen: false).remember;
      
      if(remember){

         email = Provider.of<AuthProvider>(context, listen: false).email;
      password = Provider.of<AuthProvider>(context, listen: false).password;
      }
      print("Se recuerda?: $email");
    return BaseView<LoginModel>(
        builder: (context, model, child) => Scaffold(
            body:
                // Provider.of<User>(context, listen: false).logged == true ?  CourseListView() :
                model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: Center(
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text("Login"),
                            ),
                            body: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: email,
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
                                    initialValue: password,
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
                                        onPressed: () async {
                                          // Validate returns true if the form is valid, or false
                                          // otherwise.
                                          if (_formKey.currentState
                                              .validate()) {
                                            var loginSuccess = await model
                                                    .login(email, password) ??
                                                false;
                                            if (loginSuccess) {
                                              
                                                  recordatorio(context);
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .setLoggedIn(
                                                      model.user.username,
                                                      model.user.token,
                                                      email,password);
                                            }
                                          }
                                        },
                                        child: Text('LogIn'),
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SingUpView()));
                                    },
                                    child: Text(
                                      'Crear usuario',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  )),
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
Future<void> recordatorio(BuildContext context){
return showDialog(
    context: context,
    builder: (BuildContext context){
        return AlertDialog(
          title: Text("¿Quiere ser recordado?"),
          content: Text("Esto le ayudará a ingresar mas rápido a la aplicación"),
          actions:[
      FlatButton(
        child: Text("Recordar"),
        onPressed: (){
           Provider.of<AuthProvider>(context, listen: false).setRemember(true);
           Navigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Text("No recordar"),
        onPressed: (){
           Provider.of<AuthProvider>(context, listen: false).setRemember(false);
           Navigator.of(context).pop();
        },)
    ],
        );
    }
  );



}
