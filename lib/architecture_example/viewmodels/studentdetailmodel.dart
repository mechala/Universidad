import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/student.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';

import '../locator.dart';

class StudentDetailModel extends BaseModel {
  Api _api = locator<Api>();

  StudentDetail studentDetail;

  Future getStudent(String user, String token, int studentId) async {
    try{
    setState(ViewState.Busy);
    studentDetail = await _api.getStudent(user, token, studentId);
    setState(ViewState.Idle);
    }catch(e){
    print("Error getting Student ${e.toString()}");
    setState(ViewState.Idle);
    return Future.error(e.toString());
    }
  }
}
