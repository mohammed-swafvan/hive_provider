import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/db/model/student_model.dart';

class StudentProvider with ChangeNotifier {
  //add
  final nameStudentController = TextEditingController();
  final phoneStudentController = TextEditingController();
  final ageStudentController = TextEditingController();
  final genderStudentController = TextEditingController();
  final locationStudentController = TextEditingController();
  final mainFormKey = GlobalKey<FormState>();

  //edit
  TextEditingController editNameStd = TextEditingController();
  TextEditingController editPhoneStd = TextEditingController();
  TextEditingController editAgeStd = TextEditingController();
  TextEditingController editPlaceStd = TextEditingController();
  final editFormKey = GlobalKey<FormState>();

  static List<StudentModel> studentList = [];

  File? studentPhoto;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      studentPhoto = photoTemp;
    }
    notifyListeners();
  }

  List<StudentModel> foundedUsers = [];
  Future<List<StudentModel>> getAllStudents() async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    studentList.clear();

    studentList.addAll(studentDb.values);
    foundedUsers = studentList;
    return studentList;
  }

  Future<void> addStudent(data) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    await studentDb.put(data.id, data);
    studentList.add(data);
    getAllStudents();
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    List<StudentModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = studentList;
    } else {
      result = studentList.where((element) => element.name.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    foundedUsers = result;
    notifyListeners();
  }

  Future<void> editList(int index, StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    studentDb.putAt(index, value);
    getAllStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(id) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    await studentDb.delete(id);
    getAllStudents();
    notifyListeners();
  }
}
