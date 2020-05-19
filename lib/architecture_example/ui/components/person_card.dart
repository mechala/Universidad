import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String userName;
  final String email;
  final Function getPersonDetail;

  PersonCard({this.name, this.userName, this.email, this.getPersonDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2,
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 1),
      child: Padding(
          padding: EdgeInsets.all(12.0),
          child: ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 60.0,
              color: Colors.redAccent,
            ),
            title: Text(name),
            subtitle: Text('$userName\n$email'),
            isThreeLine: true,
            onTap: getPersonDetail,
          )),
    );
  }
}
