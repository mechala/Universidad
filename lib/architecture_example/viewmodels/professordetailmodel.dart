import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/professor.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';

import '../locator.dart';

class ProfessorDetailModel extends BaseModel {
  Api _api = locator<Api>();

  ProfessorDetail professorDetail;

  Future getProfessor(
    String user, String token, int professorId) async {
    setState(ViewState.Busy);
    professorDetail = await _api.getProfessor(user, token, professorId);
    setState(ViewState.Idle);
  }
}
