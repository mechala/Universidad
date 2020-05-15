
import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/course.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/couses_service.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/student_service.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/professor_service.dart';

import '../locator.dart';
import '../models/person.dart';

class HomeModel extends BaseModel {
  CourseService _couseService = locator<CourseService>();
  StudentService _studentService =locator<StudentService>();
  ProfessorService _professorService =locator<ProfessorService>();
  List<Course> get courses => _couseService.couses;
  List<Person> get students => _studentService.students;
  List<Person> get professors => _professorService.professors;
  bool dataAvailable = true;

  Future getCourses(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _couseService.getCourses(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('homemodel getCourses ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }

   
  }

 Future getStudents(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _studentService.getStudents(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('homemodel getStudent ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }

   
  }
  Future getProfessors(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _professorService.getProfessors(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('homemodel getStudent ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }

   
  }
  Future addStudent() async {
    setState(ViewState.Busy);
  try {
      await _studentService.addStudent();
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('homemodel addCourse ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}