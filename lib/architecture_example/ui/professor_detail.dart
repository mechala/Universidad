import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/professordetailmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/person_detail.dart';

class ProfessorDetailView extends StatelessWidget {
  final int professorId;
  ProfessorDetailView({this.professorId});
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfessorDetailModel>(
        onModelReady: (model) => model.getProfessor(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,
            professorId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Professor detail"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: PersonDetail(
                    context: context,
                    name: model.professorDetail.name,
                    username: model.professorDetail.username,
                    email: model.professorDetail.email,
                    country: model.professorDetail.country,
                    city: model.professorDetail.city,
                    phone: model.professorDetail.phone,
                    birthday: model.professorDetail.birthday,
                  ))));
  }
}
