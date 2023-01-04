import 'dart:convert';

import 'package:araplantas_mobile/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserApi {
  final String _baseUrl = dotenv.env['API_URL']!;

  Future<List<User>> findAll() async {
    Uri url = Uri.http(_baseUrl, "/users");
    final Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> users =
          body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw "Can't get users.";
    }
  }

  Future<User> findById(String id) async {
    Uri url = Uri.http(_baseUrl, "/users/$id");
    final Response response = await http.get(url);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw "Can't get user.";
    }
  }

  Future<http.Response> create(User user) async {
    Uri url = Uri.http(_baseUrl, "/users");
    final Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': user.name!,
        'email': user.email!,
        'password': user.password!,
        'password_confirmation': user.password!
      }),
    );
    return response;
  }

  Future<http.Response> delete(String id) {
    Uri url = Uri.http(_baseUrl, "/users/$id");
    return http.delete(url);
  }
}
