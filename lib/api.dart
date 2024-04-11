import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static Future<http.Response> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://ec2-3-109-214-63.ap-south-1.compute.amazonaws.com:4000/api/v1/user/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  static Future<http.Response> registerUser(String firstName, String lastName,
      String email, String password, String phone) async {
    final response = await http.post(
      Uri.parse(
          'http://ec2-3-109-214-63.ap-south-1.compute.amazonaws.com:4000/api/v1/create'),
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phone': phone,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  static Future<bool> forgotPassword(String email) async {
    var url = Uri.parse(
        'http://ec2-3-109-214-63.ap-south-1.compute.amazonaws.com:4000/api/v1/forgot/password');
    var response = await http.post(url, body: {
      'email': email,
    });
    return response.statusCode == 200;
  }

  static Future<bool> resetPassword(String otp, String password) async {
    var url = Uri.parse(
        'http://ec2-3-109-214-63.ap-south-1.compute.amazonaws.com:4000/api/v1/reset/password');
    var response = await http.post(
      url,
      body: {'otp': otp, 'password': password},
    );
    return response.statusCode == 200;
  }
}
