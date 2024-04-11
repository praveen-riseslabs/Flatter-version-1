import 'package:flutter/material.dart';
import 'package:register/api.dart';
import 'package:register/resetpass.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  void _resetEmail(context) async {
    final String email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your email address')));
      return;
    }

    final bool emailSent = await APIService.forgotPassword(email);
    if (emailSent) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully sent OTP to your email address')));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => const ResetPasswordScreen())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to send OTP to your email address')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter your email address to reset your password.',
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 152, 3, 160)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _resetEmail(context),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
