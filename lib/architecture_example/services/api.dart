import 'dart:convert';
import 'dart:io';

import 'package:f_202010_provider_get_it/architecture_example/models/course.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/course_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/student.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/user.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/professor.dart';
import 'package:http/http.dart' as http;

import '../models/person.dart';


/// The service responsible for networking requests
class Api {
  static const String baseUrl = 'https://movil-api.herokuapp.com';

  var client = new http.Client();

  Future<User> getUserProfile({String email, String password}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    // print('${response.body}');
    // print('${response.statusCode}');
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      return Future.error(body['error']);
    }
  }

  Future<User> addUserProfile({String email, String password, String username, String name}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
        'name': name,
      }),
    );
    // print('${response.body}');
    // print('${response.statusCode}');
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      return Future.error(body['error']);
    }
  }

  Future<List<Person>> getStudents(String username, String token) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/students',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'showCoursesService username $username token $token => ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //return UserInfo.fromJson(json.decode(response.body));
      List<Person> studentsList = [];
      for (Map i in data) {
        print('Student $i');
        studentsList.add(Person.fromJson(i));
      }
      print('showCoursesService length ${studentsList.length}');
      return studentsList;
    } else {
      //Map<String, dynamic> body = json.decode(response.body);
      //String error = body['error'];
      //print('error  $error');
      return Future.error(response.statusCode.toString());
    }
  }
Future<List<Person>> getProfessors(String username, String token) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/professors',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'showCoursesService username $username token $token => ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //return UserInfo.fromJson(json.decode(response.body));
      List<Person> professorsList = [];
      for (Map i in data) {
        print('Professor $i');
        professorsList.add(Person.fromJson(i));
      }
      print('showCoursesService length ${professorsList.length}');
      return professorsList;
    } else {
      //Map<String, dynamic> body = json.decode(response.body);
      //String error = body['error'];
      //print('error  $error');
      return Future.error(response.statusCode.toString());
    }
  }

  Future<List<Course>> getCourses(String username, String token) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/courses',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'showCoursesService username $username token $token => ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //return UserInfo.fromJson(json.decode(response.body));
      List<Course> couseList = [];
      for (Map i in data) {
        print('course $i');
        couseList.add(Course.fromJson(i));
      }
      print('showCoursesService length ${couseList.length}');
      return couseList;
    } else {
      //Map<String, dynamic> body = json.decode(response.body);
      //String error = body['error'];
      //print('error  $error');
      return Future.error(response.statusCode.toString());
    }
  }

  Future<CourseDetail> getCourse(String username, String token, int courseId) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/courses/$courseId',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'getCourse username $username token $token => ${response.statusCode}');
    print(response.body);
    if (response.statusCode == 200) {
      return CourseDetail.fromJson(json.decode(response.body));
    } else {
      //Map<String, dynamic> body = json.decode(response.body);
      //String error = body['error'];
      //print('error  $error');
      return Future.error(response.statusCode.toString());
    }
  }

  Future<StudentDetail> getStudent(String username, String token, int studentId) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/students/$studentId',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'getCourse username $username token $token => ${response.statusCode}');
    print(response.body);
    if (response.statusCode == 200) {
      return StudentDetail.fromJson(json.decode(response.body));
    } else {
      //Map<String, dynamic> body = json.decode(response.body);
      //String error = body['error'];
      //print('error  $error');
      return Future.error(response.statusCode.toString());
    }
  }

  Future<Person> addStudentService(String username, String token,int courseId) async {
    print("Username: $username, Toke: $token, courseId: $courseId");
     final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/$username/students',

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
         HttpHeaders.authorizationHeader: "Bearer " + token,
      },
      body: jsonEncode(<String, int>{
        'courseId':courseId,
      }),
    );
    // print('${response.body}');
    // print('${response.statusCode}');
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      return Future.error(body['error']);
    }
  }


  Future<Course> addCourseService(String username, String token) async {
    final http.Response response = await http.post(
      baseUrl + '/' + username + '/courses',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('token $token');
    print('${response.statusCode}');
    print('$response');
    if (response.statusCode == 200) {
      // print('${response.body}');
      return Course.fromJson(json.decode(response.body));
    } else {
      //throw Exception('Failed to register user');
      Map<String, dynamic> body = json.decode(response.body);
      String error = body['error'];
      print('error  $error');
      return Future.error(error);
    }
  }

  Future<ProfessorDetail> getProfessor(String username, String token, int professorId) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/professors/$professorId',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'getCourse username $username token $token => ${response.statusCode}');
    print(response.body);
    if (response.statusCode == 200) {
      return ProfessorDetail.fromJson(json.decode(response.body));
    } else {
      //Map<String, dynamic> body = json.decode(response.body);
      //String error = body['error'];
      //print('error  $error');
      return Future.error(response.statusCode.toString());
    }
  }
}
