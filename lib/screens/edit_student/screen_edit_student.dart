import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/db/db_functions/db_functions.dart';
import 'package:student_app/db/model/student_model.dart';
import 'package:student_app/screens/home/screen_home.dart';

class EditingStudent extends StatelessWidget {
  final String editName;
  final String editPhone;
  final String editAge;
  final String image;
  final String editLocation;
  final String editGender;
  final String id;
  final int index;

  EditingStudent(
      {super.key,
      required this.editName,
      required this.editPhone,
      required this.editAge,
      required this.editGender,
      required this.editLocation,
      required this.id,
      required this.image,
      required this.index});

  TextEditingController nameOfStudent = TextEditingController();
  TextEditingController phoneOfStudent = TextEditingController();
  TextEditingController ageOfStudent = TextEditingController();
  TextEditingController genderOfStudent = TextEditingController();
  TextEditingController locationOfStudent = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameOfStudent = TextEditingController(text: editName);
    phoneOfStudent = TextEditingController(text: editPhone);
    ageOfStudent = TextEditingController(text: editAge);
    genderOfStudent = TextEditingController(text: editGender);
    locationOfStudent = TextEditingController(text: editLocation);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing Room'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Text(
                    'Edit Student Details',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(
                      File(image),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameOfStudent,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '', labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLength: 10,
                    controller: phoneOfStudent,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter Phone Number', labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required PhoneNo';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLength: 2,
                    controller: ageOfStudent,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter Age', labelText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: genderOfStudent,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Enter Your Sexuality', labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: locationOfStudent,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder(), hintText: 'Current Place', labelText: 'Place'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              onEditSaveButton(context);
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('SAVE'))
                    ],
                  )
                ],
              ),
            )),
      )),
    );
  }

  Future<void> onEditSaveButton(ctx) async {
    final studentmodel = StudentModel(
      name: nameOfStudent.text,
      phoneNo: phoneOfStudent.text,
      ageStudent: ageOfStudent.text,
      genderStudent: genderOfStudent.text,
      locationStudent: locationOfStudent.text,
      photo: image.toString(),
      id: id,
    );

    Provider.of<FunctionDb>(ctx, listen: false).editList(index, studentmodel);
    Navigator.push(ctx, MaterialPageRoute(builder: (context) => const HomeScreen(),));
  }
}
