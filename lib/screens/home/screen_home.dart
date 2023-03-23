import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/core/constains.dart';
import 'package:student_app/controller/provider/student_provider.dart';
import 'package:student_app/screens/home/widgets/studenst_list.dart';
import 'package:student_app/screens/student_adding/screen_add_student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider.getAllStudents();
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: ListStudents()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kWhiteColorOpacity5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenAddStudent(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
