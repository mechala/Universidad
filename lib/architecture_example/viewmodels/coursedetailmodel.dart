import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/course_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/student_service.dart';

import '../locator.dart';
import '../models/person.dart';

class CourseDetailModel extends BaseModel {
  Api _api = locator<Api>();
  StudentService _studentService = locator<StudentService>();
  List<Person> get students => _studentService.students;
  CourseDetail courseDetail;

  Future getCourse(String user, String token, int courseId) async {
    try {
      setState(ViewState.Busy);
      courseDetail = await _api.getCourse(user, token, courseId);
      setState(ViewState.Idle);
    } catch (e) {
      print('homemodel getCourse ${e.toString()}');
      setState(ViewState.Idle);
      return Future.error(e.toString());
    }
  }

  Future addStudent(int courseId) async {
    setState(ViewState.Busy);
    try {
      await _studentService.addStudent(courseId);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('CourseDetailModel addStudent ${err.toString()}');
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}
