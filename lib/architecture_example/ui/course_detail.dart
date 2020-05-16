import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
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
            floatingActionButton: floating(context, model,model.courseDetail.professor.id),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: Text('Course: ${model.courseDetail.name}')),
                      Center(
                          child: Text(
                              'Professor: ${model.courseDetail.professor.name}')),
                      Center(
                        child: FlatButton(
                            child: Text(
                                'Student #1: ${model.courseDetail.students[0].name}'),
                            onPressed: () async {
                              print("Vamoa a buscar al estudiante");

                              getDetail(context, model.courseDetail.students[0].id);
                             
                            }),
                      ),
                    ],
                  ))));
  }
}
Widget floating(BuildContext context, CourseDetailModel model,int courseId) {
    return FloatingActionButton(
        onPressed: () => _onAdd(context, model,courseId),
        tooltip: 'Add task',
        child: new Icon(Icons.add));
  }

  void _onAdd(BuildContext context, CourseDetailModel model,int courseId) async {
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