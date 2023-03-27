import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/provider/splash_provider.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashProvider.gotoMainPage(context);
    });
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/splash-icon.png'), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
