import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      var box = Hive.box('userBox');

      if (box.get('currentEmail') != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => const HomeScreen())
        );
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => const LoginScreen())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF434343), Color(0xFF000000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.5),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                  Icons.auto_awesome,
                  size: 100,
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'QUIZ QUEST',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 6,
                fontFamily: 'Roboto',
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Unleash Your Knowledge',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
                letterSpacing: 1.5,
                fontWeight: FontWeight.w300,
              ),
            ),

            const SizedBox(height: 80),

            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}