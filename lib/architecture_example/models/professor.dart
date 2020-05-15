class ProfessorDetail {
  int courseid;
  String name;
  String username;
  String email;
  String phone;
  String city;
  String country;
  String birthday;
  ProfessorDetail(
      {this.courseid,
      this.name,
      this.username,
      this.email,
      this.birthday,
      this.city,
      this.country,
      this.phone});

  ProfessorDetail.initial()
      : courseid = 0,
        name = '',
        username = '',
        email = '',
        birthday = '',
        city = '',
        country = '',
        phone = '';

  ProfessorDetail.fromJson(Map<String, dynamic> json) {
    courseid = json['course_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    birthday = json['birthday'];
    city = json['city'];
    country = json['country'];
    phone = json['phone'];
  }
}
