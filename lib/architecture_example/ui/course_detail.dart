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
                              /*  var loginSuccess = await model.login();
                        if (loginSuccess) {
                          print('LoginView loginSuccess setting up setLoggedIn ');
                          Provider.of<AuthProvider>(context, listen: false).setLoggedIn(model.user.username,model.user.token);
                        } */
                            }),
                      ),
                    ],
                  ))));
  }
}
void getDetail(BuildContext context, int studentId) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => StudentDetailView(studentId: studentId)),
    );
  }