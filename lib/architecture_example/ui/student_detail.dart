import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/studentdetailmodel.dart';
import 'components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailView extends StatelessWidget {
  final int studentId;
  StudentDetailView({this.studentId});
  @override
  Widget build(BuildContext context) {
    return BaseView<StudentDetailModel>(
        onModelReady: (model) => model.getStudent(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,
            studentId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Student detail"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: PersonDetail(
                    context: context,
                    name: model.studentDetail.name,
                    username: model.studentDetail.username,
                    email: model.studentDetail.email,
                    country: model.studentDetail.country,
                    city: model.studentDetail.city,
                    phone: model.studentDetail.phone,
                    birthday: model.studentDetail.birthday,
                  ))));
  }
}
