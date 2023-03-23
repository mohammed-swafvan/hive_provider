import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/core/constains.dart';
import 'package:student_app/controller/provider/student_provider.dart';
import 'package:student_app/screens/edit_student/screen_edit_student.dart';
import 'package:student_app/screens/home/widgets/search_field.dart';
import 'package:student_app/screens/students_details/screen_students_details.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          kHeight10,
          const SearchField(),
          kHeight20,
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
                                  photo: data.photo,
                                );
                              }),
                            ));
                          },
                          leading: CircleAvatar(
                            radius: 23,
                            backgroundImage: FileImage(File(data.photo)),
                          ),
                          title: Text(
                            data.name,
                            style: const TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                                    return EditingStudent(
                                      editName: data.name,
                                      editPhone: data.phoneNo,
                                      editAge: data.ageStudent,
                                      editLocation: data.locationStudent,
                                      index: index,
                                      id: data.id.toString(),
                                      image: data.photo,
                                    );
                                  })));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: kWhiteColorOpacity5,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  StudentProvider.deleteItem(context, data.id.toString());
                                },
                                icon: const Icon(Icons.delete),
                                color: kWhiteColorOpacity5,
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: ((ctx, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: kWhiteColorOpacity5,
                            thickness: 1,
                          ),
                        )),
                    itemCount: value.foundedUsers.length);
              } else {
                return const Center(
                  child: Text(
                    "Add Students",
                    style: kaddStdTextStyle,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
