import 'package:flutter/material.dart';

import 'package:register/api.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String phone = _phoneController.text;

      APIService.registerUser(firstName, lastName, email, password, phone)
          .then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Failed')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Registration',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 59, 126, 181),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 400.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                        controller: _firstNameController,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: _lastNameController,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Address is required';
                          }
                          return null;
                        }),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
