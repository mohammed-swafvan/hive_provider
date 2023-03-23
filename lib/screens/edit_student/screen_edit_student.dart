import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/core/constains.dart';
import 'package:student_app/controller/provider/student_provider.dart';
import 'package:student_app/db/db_functions/db_functions.dart';
import 'package:student_app/db/model/student_model.dart';

// ignore: must_be_immutable
class EditingStudent extends StatelessWidget {
  final String editName;
  final String editPhone;
  final String editAge;
  final String image;
  final String editLocation;
  final String id;
  final int index;

  const EditingStudent(
      {super.key,
      required this.editName,
      required this.editPhone,
      required this.editAge,
      required this.editLocation,
      required this.id,
      required this.image,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: const Text('Editing Room'),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<StudentProvider>(builder: (context, data, _) {
          data.editNameStd = TextEditingController(text: editName);
          data.editPhoneStd = TextEditingController(text: editPhone);
          data.editAgeStd = TextEditingController(text: editAge);
          data.editPlaceStd = TextEditingController(text: editLocation);
          return Form(
              key: data.editFormKey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(
                        File(image),
                      ),
                    ),
                    kHeight20,
                    TextFormField(
                      style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
                      controller: data.editNameStd,
                      decoration: kInputDecoration(hintText: 'Edit name', labelText: 'Name'),
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
                      maxLength: 10,
                      controller: data.editPhoneStd,
                      keyboardType: TextInputType.number,
                      decoration: kInputDecoration(hintText: 'Edit mobile', labelText: 'Mobile'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required PhoneNo';
                        } else {
                          return null;
                        }
                      },
                    ),
                    kHeight10,
                    TextFormField(
                      style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
                      maxLength: 2,
                      controller: data.editAgeStd,
                      keyboardType: TextInputType.number,
                      decoration: kInputDecoration(hintText: 'Edit age', labelText: 'Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Age';
                        } else {
                          return null;
                        }
                      },
                    ),
                    kHeight10,
                    TextFormField(
                      style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
                      controller: data.editPlaceStd,
                      decoration: kInputDecoration(hintText: 'Edit place', labelText: 'Location'),
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
                          if (data.editFormKey.currentState!.validate()) {
                            onEditSaveButton(
                              ctx: context,
                              editNameStd: data.editNameStd,
                              editPhoneStd: data.editPhoneStd,
                              editAgeStd: data.editAgeStd,
                              editPlaceStd: data.editPlaceStd,
                              id: id,
                              image: image,
                              index: index,
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('SAVE'))
                  ],
                ),
              ));
        }),
      )),
    );
  }
}

Future<void> onEditSaveButton({
  required ctx,
  required TextEditingController editNameStd,
  required TextEditingController editPhoneStd,
  required TextEditingController editAgeStd,
  required TextEditingController editPlaceStd,
  required id,
  required image,
  required index,
}) async {
  final studentmodel = StudentModel(
    name: editNameStd.text,
    phoneNo: editPhoneStd.text,
    ageStudent: editAgeStd.text,
    locationStudent: editPlaceStd.text,
    photo: image.toString(),
    id: id,
  );

  Provider.of<FunctionDb>(ctx, listen: false).editList(index, studentmodel);
}
