import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  final String _baseUrl = dotenv.env['API_URL']!;

  Future<http.Response> login(String email, String password) {
    Uri url = Uri.http(_baseUrl, "/login");
    return http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }
}
