import 'package:flutter/material.dart';
import 'package:student_app/presentation/home/screen_home.dart';

class SplashProvider with ChangeNotifier {
  Future<void> gotoMainPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    notifyListeners();
  }
}
