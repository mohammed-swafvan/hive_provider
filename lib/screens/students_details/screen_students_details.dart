import 'package:flutter/material.dart';

class DetailsOfStudents extends StatelessWidget {
  final String namedetail;
  final String phonedetail;
  final String agedetail;
  final String locationdetail;
  final String genderdetail;
  final String photo;

  const DetailsOfStudents({
    super.key,
    required this.namedetail,
    required this.phonedetail,
    required this.agedetail,
    required this.locationdetail,
    required this.genderdetail,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Details Of Student'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      foregroundImage: AssetImage('assets/images/Profile.png'),
                      radius: 80,
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            'NAME : $namedetail',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.teal),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'PHONE NO : $phonedetail',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.teal[400],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'PLACE : $locationdetail',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.teal[400],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'AGE : $agedetail',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.teal[400],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'GENDER : $genderdetail',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.teal[400],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
