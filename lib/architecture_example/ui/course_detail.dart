import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/components/course_detail_card.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/components/person_card.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/coursedetailmodel.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetailView extends StatelessWidget {
  final int courseId;
  CourseDetailView({this.courseId});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseDetailModel>(
        onModelReady: (model) => model.getCourse(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,
            courseId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Course detail"),
            ),
            floatingActionButton:
                floating(context, model, model.courseDetail.professor.id),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        _renderHead(
                            context,
                            model.courseDetail.name,
                            model.courseDetail.professor.name,
                            model.courseDetail.professor.username,
                            model.courseDetail.professor.email),
                        /* Expanded(
                          child: */
                        _renderBody(context, model.courseDetail.students),
                        /* ) */
                      ],
                    ))));
  }

  Widget _renderHead(BuildContext context, String course, String name,
      String username, String email) {
    return Container(
        margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.redAccent[400],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              course,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.book,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
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
          ],
        ));
  }

  Widget _renderBody(BuildContext context, List<Person> students) {
    return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        color: Colors.red,
        child: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'students'.toUpperCase(),
                  style: TextStyle(color: Colors.grey[800], fontSize: 14),
                ),
                SizedBox(height: 3),
                SizedBox(
                  height: 200,
                  child: ListView(
                      children: students.map((student) {
                    PersonCard(
                      name: student.name,
                      userName: student.username,
                      email: student.email,
                      getPersonDetail: () => getDetail(context, student.id),
                    );
                  }).toList()),
                )
              ],
            )));
  }
}

Widget floating(BuildContext context, CourseDetailModel model, int courseId) {
  return FloatingActionButton(
      onPressed: () => _onAdd(context, model, courseId),
      tooltip: 'Add task',
      child: new Icon(Icons.add));
}

void _onAdd(BuildContext context, CourseDetailModel model, int courseId) async {
  try {
    await model.addStudent(courseId);
  } catch (err) {
    print('upsss ${err.toString()}');
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

void getDetail(BuildContext context, int studentId) async {
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
