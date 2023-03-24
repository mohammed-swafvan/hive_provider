import 'package:flutter/material.dart';
import 'package:student_app/presentation/home/screen_home.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoMainPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash-icon.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Future<void> gotoMainPage() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }
}
