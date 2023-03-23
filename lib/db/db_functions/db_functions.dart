import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/db/model/student_model.dart';

class FunctionDb with ChangeNotifier {
  static List<StudentModel> studentList = [];
  Future<void> addStudents(StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('Student_db');
    await studentDb.put(value.id, value);

    studentList.add(value);
    getStudentsDetails();
  }

  Future<List<StudentModel>> getStudentsDetails() async {
    final studentDb = await Hive.openBox<StudentModel>('Student_db');
    studentList.clear();

    studentList.addAll(studentDb.values);
    return studentList;
  }

  Future<void> deleteDetails(String id) async {
    final studentDb = await Hive.openBox<StudentModel>('Student_db');
    await studentDb.delete(id);
    getStudentsDetails();
    notifyListeners();
  }

  Future<void> editList(int id, StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    studentDb.putAt(id, value);
    getStudentsDetails();
    notifyListeners();
  }
}
