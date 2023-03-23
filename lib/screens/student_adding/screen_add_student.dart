import 'package:flutter/material.dart';
import 'package:student_app/screens/student_adding/widgets/add_student.dart';

class ScreenAddStudent extends StatelessWidget {
  const ScreenAddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: AddStudents(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
