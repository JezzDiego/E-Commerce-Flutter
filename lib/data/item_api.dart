import 'dart:convert';

import 'package:araplantas_mobile/models/item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ItemApi {
  final String _baseUrl = dotenv.env['API_URL']!;

  Future<List<Item>> findAll() async {
    Uri url = Uri.http(_baseUrl, "/items");
    final Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Item> items =
          body.map((dynamic item) => Item.fromJson(item)).toList();
      return items;
    } else {
      throw "Can't get items.";
    }
  }

  Future<Item> findById(String id) async {
    Uri url = Uri.http(_baseUrl, "/items/$id");
    final Response response = await http.get(url);
    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw "Can't get item.";
    }
  }

  Future<http.Response> create(Item item) {
    Uri url = Uri.http(_baseUrl, "/items");
    return http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: item.toJson(),
    );
  }

  Future<http.Response> delete(String id) {
    Uri url = Uri.http(_baseUrl, "/items/$id");
    return http.delete(url);
  }
}
