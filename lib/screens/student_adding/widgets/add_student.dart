import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/core/constains.dart';
import 'package:student_app/controller/provider/student_provider.dart';
import 'package:student_app/db/model/student_model.dart';

class AddStudents extends StatelessWidget {
  const AddStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.studentPhoto = null;
    });
    return Consumer<StudentProvider>(builder: (context, value, _) {
      return Form(
        key: value.mainFormKey,
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
              style: kelevatedButtonStyle,
              onPressed: () {
                studentProvider.getPhoto();
              },
              child: const Icon(Icons.photo_library_outlined),
            ),
            kHeight20,
            TextFormField(
              style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.name,
              controller: value.nameStudentController,
              decoration: kInputDecoration(hintText: 'Enter your name', labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required Name';
                } else {
                  return null;
                }
              },
            ),
            kHeight10,
            TextFormField(
              style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              controller: value.ageStudentController,
              decoration: kInputDecoration(hintText: 'Enter your age', labelText: 'Age'),
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
            kHeight10,
            TextFormField(
              style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.phone,
              controller: value.phoneStudentController,
              decoration: kInputDecoration(hintText: 'Enter monile no', labelText: 'Mobile'),
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
            kHeight10,
            TextFormField(
              style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.text,
              controller: value.locationStudentController,
              decoration: kInputDecoration(hintText: 'Enter your place', labelText: 'Location'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required Place';
                } else {
                  return null;
                }
              },
            ),
            kHeight20,
            ElevatedButton.icon(
              style: kelevatedButtonStyle,
              onPressed: () {
                if (value.mainFormKey.currentState!.validate() && studentProvider.studentPhoto != null) {
                  addStudentButtonClicked(
                    context,
                    value.nameStudentController,
                    value.ageStudentController,
                    value.phoneStudentController,
                    value.locationStudentController,
                  );
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

  Future<void> addStudentButtonClicked(
    context,
    TextEditingController nameCntlr,
    TextEditingController ageCntrl,
    TextEditingController phoneCntrl,
    TextEditingController locationCntrl,
  ) async {
    final name = nameCntlr.text.trim();
    final phone = phoneCntrl.text.trim();
    final age = ageCntrl.text.trim();
    final location = locationCntrl.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        age.isEmpty ||
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
      locationStudent: location,
      photo: Provider.of<StudentProvider>(context, listen: false).studentPhoto!.path,
      id: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    Provider.of<StudentProvider>(context, listen: false).addStudent(student);
    Provider.of<StudentProvider>(context, listen: false).getAllStudents();
  }
}
