import 'dart:ffi';

import 'package:f_202010_provider_get_it/architecture_example/models/course.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final Function getDetails;
  CourseCard({this.course, this.getDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              course.name,
              style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              'Professor: ${course.professor}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              'Students: ${course.students}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
            ),
            SizedBox(
              height: 8.0,
            ),
            FlatButton.icon(
                onPressed: getDetails,
                icon: Icon(Icons.arrow_forward),
                label: Text("See Details"))
          ],
        ),
      ),
    );
  }
}
