import 'package:flutter/material.dart';

import 'package:register/api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      APIService.loginUser(email, password).then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Successful')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Failed')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login into your account',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 59, 126, 181),
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 400.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Address is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password', hintText: 'Enter your Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter your email')));
                        } else {
                          Navigator.pushNamed(context, '/forgotPassword');
                        }
                      },
                      child: const Text('Forgot password'))
                ],
              ),
            ),
          ),
        )));
  }
}
