import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonDetailCard extends StatelessWidget {
  final BuildContext context;
  final String name;
  final String username;
  final String email;
  final String country;
  final String city;
  final String phone;
  final String birthday;

  PersonDetailCard(
      {this.context,
      this.name,
      this.username,
      this.email,
      this.country,
      this.city,
      this.phone,
      this.birthday});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        )),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _renderHead(context, name, username, email),
            _renderBody(context, country, city, phone, birthday)
          ],
        ));
  }

  Widget _renderHead(
      BuildContext context, String name, String username, String email) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.redAccent[400],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: Icon(
              Icons.assignment_ind,
              size: 80,
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                username,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderBody(BuildContext context, String country, String city,
      String phone, String birthday) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white60,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            'country'.toUpperCase(),
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
          SizedBox(height: 3),
          Text(
            country,
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
          SizedBox(height: 15),
          Text(
            'city'.toUpperCase(),
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
          SizedBox(height: 3),
          Text(
            city,
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
          SizedBox(height: 15),
          Text(
            'phone'.toUpperCase(),
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
          SizedBox(height: 3),
          Text(
            phone,
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
          SizedBox(height: 15),
          Text(
            'birthday'.toUpperCase(),
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
          SizedBox(height: 3),
          Text(
            DateFormat.yMMMMd('en_US')
                .format(DateTime.parse(birthday))
                .toString(),
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
