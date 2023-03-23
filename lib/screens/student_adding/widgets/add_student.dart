import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/provider/student_provider.dart';
import 'package:student_app/db/db_functions/db_functions.dart';
import 'package:student_app/db/model/student_model.dart';

class AddStudents extends StatelessWidget {
  AddStudents({super.key});

  final nameStudentController = TextEditingController();
  final phoneStudentController = TextEditingController();
  final ageStudentController = TextEditingController();
  final genderStudentController = TextEditingController();
  final locationStudentController = TextEditingController();

  final mainFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.studentPhoto = null;
    });
    return Consumer<StudentProvider>(builder: (context, value, _) {
      return Form(
        key: mainFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            value.studentPhoto == null
                ? const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/Profile.png'),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(
                      File(
                        value.studentPhoto!.path,
                      ),
                    ),
                    radius: 60,
                  ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                studentProvider.getPhoto();
              },
              child: const Icon(Icons.photo_library_outlined),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nameStudentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required Name';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: ageStudentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your age',
                labelText: 'Age',
              ),
              validator: (
                value,
              ) {
                if (value == null || value.isEmpty) {
                  return 'Required Age ';
                } else if (value.length > 100) {
                  return 'Enter Correct Age';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneStudentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Mobile No',
                labelText: 'Mobile No',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Phone Number';
                } else if (value.length != 10) {
                  return 'Require valid Phone Number';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: locationStudentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter school place',
                labelText: 'School',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required Place';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 13),
            ElevatedButton.icon(
              onPressed: () {
                if (mainFormKey.currentState!.validate() && studentProvider.studentPhoto != null) {
                  addStudentButtonClicked(context);
                  Navigator.of(context).pop();
                } else {}
              },
              icon: const Icon(Icons.add),
              label: const Text('ADD STUDENTS'),
            ),
          ],
        ),
      );
    });
  }

  Future<void> addStudentButtonClicked(context) async {
    final name = nameStudentController.text.trim();
    final phone = phoneStudentController.text.trim();
    final age = ageStudentController.text.trim();
    final gender = genderStudentController.text.trim();
    final location = locationStudentController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        age.isEmpty ||
        gender.isEmpty ||
        location.isEmpty ||
        Provider.of<StudentProvider>(context, listen: false).studentPhoto!.path.isEmpty) {
      return;
    } else {
      Provider.of<StudentProvider>(context, listen: false).getAllStudents();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text("Student Added Successfully"),
        ),
      );
    }
    final student = StudentModel(
      name: name,
      phoneNo: phone,
      ageStudent: age,
      genderStudent: gender,
      locationStudent: location,
      photo: Provider.of<StudentProvider>(context, listen: false).studentPhoto!.path,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    Provider.of<FunctionDb>(context, listen: false).addStudents(student);
    Provider.of<FunctionDb>(context, listen: false).getStudentsDetails();
  }
}
