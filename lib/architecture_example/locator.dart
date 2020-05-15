import 'package:get_it/get_it.dart';

import 'services/api.dart';
import 'services/authentication_service.dart';
import 'services/couses_service.dart';
import 'services/student_service.dart';
import 'services/professor_service.dart';
import 'viewmodels/coursedetailmodel.dart';
import 'viewmodels/homemodel.dart';
import 'viewmodels/loginmodel.dart';
import 'viewmodels/singupmodel.dart';
import 'viewmodels/studentdetailmodel.dart';
import 'viewmodels/professordetailmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() =>   CourseService());
  locator.registerLazySingleton(() =>   StudentService());
  locator.registerLazySingleton(() =>   ProfessorService());
  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => SingUpModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => CourseDetailModel());
  locator.registerFactory(() => StudentDetailModel());
  locator.registerFactory(() => ProfessorDetailModel());
}
