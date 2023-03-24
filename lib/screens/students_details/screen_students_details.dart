import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app/controller/core/constains.dart';

class DetailsOfStudents extends StatelessWidget {
  final String namedetail;
  final String phonedetail;
  final String agedetail;
  final String locationdetail;
  final String photo;

  const DetailsOfStudents({
    super.key,
    required this.namedetail,
    required this.phonedetail,
    required this.agedetail,
    required this.locationdetail,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBlackColor,
          title: const Text('All Details Of Student'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(color: kWhiteColor.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                kHeight10,
                CircleAvatar(
                  foregroundImage: FileImage(File((photo))),
                  radius: 70,
                ),
                Text(
                  'NAME : $namedetail',
                  style: kdetailsTextStyle,
                ),
                Text(
                  'PHONE NO : $phonedetail',
                  style: kdetailsTextStyle,
                ),
                Text(
                  'PLACE : $locationdetail',
                  style: kdetailsTextStyle,
                ),
                Text(
                  'AGE : $agedetail',
                  style: kdetailsTextStyle,
                ),
                kHeight10,
              ],
            ),
          ),
        ));
  }
}
