import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/provider/student_provider.dart';
import 'package:student_app/screens/edit_student/screen_edit_student.dart';
import 'package:student_app/screens/students_details/screen_students_details.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CupertinoSearchTextField(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.close),
            backgroundColor: Colors.white,
            onChanged: (value) {
              Provider.of<StudentProvider>(context, listen: false)
                  .runFilter(value);
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<StudentProvider>(builder: (context, value, Widget? child) {
              if (value.foundedUsers.isNotEmpty) {
                return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final data = value.foundedUsers[index];
                      return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: ((context) {
                                return DetailsOfStudents(
                                    namedetail: data.name,
                                    phonedetail: data.phoneNo,
                                    agedetail: data.ageStudent,
                                    locationdetail: data.locationStudent,
                                    genderdetail: data.genderStudent, photo: data.photo,);
                              }),
                            ));
                          },
                          leading: CircleAvatar(
                            radius: 23,
                            backgroundImage: FileImage(File(data.photo)),
                          ),
                          title: Text(data.name),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                                      return EditingStudent(
                                        editName: data.name,
                                        editPhone: data.phoneNo,
                                        editAge: data.ageStudent,
                                        editGender: data.genderStudent,
                                        editLocation: data.locationStudent,
                                        index: index, 
                                        id: data.id.toString(),
                                        image: data.photo,
                                      );
                                    })));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                onPressed: () {
                                  StudentProvider.deleteItem(context, data.id.toString());
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.teal,
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: ((ctx, index) => const Divider()),
                    itemCount: value.foundedUsers.length);
              } else {
                return const Center(
                  child: Text("Add Students"),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  cancelButton(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
