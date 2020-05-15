import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';

import '../locator.dart';
import 'api.dart';

class StudentService {
  Api _api = locator<Api>();

  String _user;
  String _token;
  List<Person> _students = [];
  List<Person> get students => _students;

  Future getStudents(String username, String token) async {
    _user = username;
    _token = token;
    try {
      _students = await _api.getStudents(username, token);
    } catch (err) {
      print('service getCourses ${err.toString()}');
      return Future.error(err.toString());
    }
  }

  Future addStudent() async {
    try {
      Person student = await _api.addStudentService(_user, _token);
      _students.add(student);
    } catch (err) {
      print('service addCourse ${err.toString()}');
      return Future.error(err.toString());
    }
  }
}
