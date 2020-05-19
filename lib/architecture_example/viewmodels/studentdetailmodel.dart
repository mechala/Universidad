import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/student.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import 'auth_provider.dart';

class StudentDetailModel extends BaseModel {
  Api _api = locator<Api>();

  StudentDetail studentDetail;

  Future getStudent(
      String user, String token, int studentId, BuildContext context) async {
    try {
      setState(ViewState.Busy);
      studentDetail = await _api.getStudent(user, token, studentId);
      setState(ViewState.Idle);
    } catch (e) {
      print("Error getting Student ${e.toString()}");
      setState(ViewState.Idle);
      Navigator.of(context).pop();
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
      return Future.error(e.toString());
    }
  }
}
