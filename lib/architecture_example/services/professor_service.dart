import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';

import '../locator.dart';
import 'api.dart';

class ProfessorService {
  Api _api = locator<Api>();

  String _user;
  String _token;
  List<Person> _professors = [];
  List<Person> get professors => _professors;

  Future getProfessors(String username, String token) async {
    _user = username;
    _token = token;
    try {
      _professors = await _api.getProfessors(username, token);
    } catch (err) {
      print('service getCourses ${err.toString()}');
      return Future.error(err.toString());
    }
  }

}
