import 'package:flutter/material.dart';
import 'package:register/forgotpass.dart';
import 'package:register/login.dart';
import 'package:register/reg_page.dart';
import 'package:register/home.dart';
import 'package:register/resetpass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration and Login',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/resetPassword': (context) => const ResetPasswordScreen(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
