import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app/db/db_functions/db_functions.dart';
import 'package:student_app/db/model/student_model.dart';

class StudentProvider with ChangeNotifier {
  List<StudentModel> studentList = FunctionDb.studentList;

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
  Future<void> getAllStudents() async {
    final students = FunctionDb().getStudentsDetails();
    foundedUsers = students as List<StudentModel>;
    if (foundedUsers.isNotEmpty) {
      log("foundedUsers have data");
    }
    notifyListeners();
  }

  void addStudent(data) {
    foundedUsers.clear();
    foundedUsers.addAll(data);
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


  static deleteItem(BuildContext context, String id){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure want to delete this ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Provider.of<FunctionDb>(context, listen: false)
                      .deleteDetails(id);
                  Provider.of<StudentProvider>(context, listen: false)
                      .getAllStudents();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Successfully deleted'),
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
          ],
        );
      },
    );
  }

}
