import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/professor.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import 'auth_provider.dart';

class ProfessorDetailModel extends BaseModel {
  Api _api = locator<Api>();

  ProfessorDetail professorDetail;

  Future getProfessor(String user, String token, int professorId,BuildContext context) async {
    setState(ViewState.Busy);
    try {
      professorDetail = await _api.getProfessor(user, token, professorId);
    } catch (e) {
      print("Error getting professor ${e.toString()}");
      Navigator.of(context).pop();
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
      return Future.error(e.toString());
      
    }
    setState(ViewState.Idle);
  }
}
