import 'package:f_202010_provider_get_it/architecture_example/models/course_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/components/person_card.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/student_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentList extends StatelessWidget {
  final List<Person> students;

  StudentList({this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Course\'s Student List'),
        ),
        body: Container(
            margin: EdgeInsets.all(16.0),
            child: ListView(
                children: students.map((student) {
              return PersonCard(
                name: student.name,
                userName: student.username,
                email: student.email,
                getPersonDetail: () => getStudentDetail(context, student.id),
              );
            }).toList())));
  }

  void getStudentDetail(BuildContext context, int studentId) async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => StudentDetailView(studentId: studentId)),
      );
    } catch (e) {
      print("Error getting details: $e");
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    }
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
