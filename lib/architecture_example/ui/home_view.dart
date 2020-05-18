import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/course_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/student_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/professor_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/homemodel.dart';
import 'components/course_card.dart';
import 'components/person_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CourseListView(),
    ProfessorsListView(),
    StudentsListView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Courses'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Professors'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('Students'))
        ],
      ),
    );
  }
}

class CourseListView extends StatefulWidget {
  @override
  _CourseListViewState createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView>
    with AutomaticKeepAliveClientMixin<CourseListView> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Course list"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .setLogOut();
                  },
                ),
              ],
            ),
            floatingActionButton: floating(context, model),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: model.courses == null
                        ? Text('No data')
                        : ListView(
                            // Se renderiza la lista de los cursos
                            children: model.courses
                                .map((course) => CourseCard(
                                    course: course,
                                    getDetails: () =>
                                        getDetail(context, course.id)))
                                .toList()))));
  }

  void getData(BuildContext context, HomeModel model) async {
    model
        .getCourses(Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token)
        .catchError((error) async {
      print("getCourses got error: " + error);
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    });
  }

  void getDetail(BuildContext context, int courseId) async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => CourseDetailView(courseId: courseId)),
      );
    } catch (e) {
      print("Error getting details: $e");
      await _buildDialog(context, 'Alert', "$e");
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    }
  }

  Widget floating(BuildContext context, HomeModel model) {
    return FloatingActionButton(
        onPressed: () => _onAdd(context, model),
        tooltip: 'Add task',
        child: new Icon(Icons.add));
  }

  void _onAdd(BuildContext context, HomeModel model) async {
    try {
      await model.addCourse();
    } catch (err) {
      print('upsss ${err.toString()}');
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    }
  }

  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}

class StudentsListView extends StatefulWidget {
  @override
  _StudentsListViewState createState() => _StudentsListViewState();
}

class _StudentsListViewState extends State<StudentsListView>
    with AutomaticKeepAliveClientMixin<StudentsListView> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Students list"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .setLogOut();
                  },
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: model.students == null
                        ? Text('No data')
                        : ListView(
                            children: model.students
                                .map((student) => PersonCard(
                                    name: student.name,
                                    userName: student.username,
                                    email: student.email,
                                    getPersonDetail: () =>
                                        getDetail(context, student.id)))
                                .toList(),
                          ))));
  }

  void getData(BuildContext context, HomeModel model) async {
    model
        .getStudents(Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token)
        .catchError((error) async {
      print("getStudents got error: " + error);
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    });
  }

  void getDetail(BuildContext context, int studentId) async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => StudentDetailView(studentId: studentId)),
      );
    } catch (e) {
      print("Error getting details: $e");
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    }
  }

  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}

class ProfessorsListView extends StatefulWidget {
  @override
  _ProfessorsListViewState createState() => _ProfessorsListViewState();
}

class _ProfessorsListViewState extends State<ProfessorsListView>
    with AutomaticKeepAliveClientMixin<ProfessorsListView> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Professors list"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .setLogOut();
                  },
                ),
              ],
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: model.professors == null
                        ? Text('No data')
                        : ListView(
                            children: model.professors
                                .map((prof) => PersonCard(
                                    name: prof.name,
                                    userName: prof.username,
                                    email: prof.email,
                                    getPersonDetail: () =>
                                        getDetail(context, prof.id)))
                                .toList(),
                          )
                    //Un botón que crea la view de detalles que le envias la id del professor
                    //Le pregunta a la api por el profesor y te da un objeto PERSON que puedes usar en la vista de detalles para mostrarlos
                    //Todos los getDetails funcionan igual, solo que con el id respectivo
                    )));
  }

  void getData(BuildContext context, HomeModel model) async {
    model
        .getProfessors(Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token)
        .catchError((error) async {
      print("getProfessors got error: " + error);
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    });
  }

  void getDetail(BuildContext context, int professorId) async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                ProfessorDetailView(professorId: professorId)),
      );
    } catch (e) {
      print("Error getting details: $e");
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    }
  }

  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
