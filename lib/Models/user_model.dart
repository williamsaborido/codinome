import 'package:codinome/Helpers/database_helper.dart';

class User{
  int id;
  String name;
  String password;

  User({this.id, this.name, this.password});

  factory User.fromDatabase(DatabaseHelper dbHelper, int id) {
    return User();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }

}