import 'dart:convert';

import 'package:araplantas_mobile/models/item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ItemApi {
  final String _baseUrl = dotenv.env['API_URL']!;
  String authToken;
  ItemApi({required this.authToken});

  Future<List<Item>> findAll() async {
    Uri url = Uri.http(_baseUrl, "/items");
    final Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${this.authToken}',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Item> items =
          body.map((dynamic item) => Item.fromJson(item)).toList();
      return items;
    } else {
      print(response.body);
      throw "Can't get items.";
    }
  }

  Future<Item> findById(String id) async {
    Uri url = Uri.http(_baseUrl, "/items/$id");
    final Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${this.authToken}',
      },
    );
    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw "Can't get item.";
    }
  }

  Future<List<Item>> findUserItems(String userId) async {
    Uri url = Uri.http(_baseUrl, "/users/${userId}/items");
    final Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${this.authToken}',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Item> items =
          body.map((dynamic item) => Item.fromJson(item)).toList();
      return items;
    } else {
      print(response.body);
      throw "Can´t get user items";
    }
  }

  Future<Response> saveUserItem(
      String userId, String itemId, int quantity, String status) async {
    Uri url = Uri.http(_baseUrl, "/users/${userId}/items");
    return await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${this.authToken}',
        },
        body: jsonEncode({
          "item_id": int.parse(itemId),
          "quantity": quantity,
          "status": status
        }));
  }

  Future<Item> getSavedUserItem(String itemId, String userId) async {
    Uri url = Uri.http(_baseUrl, "/users/${userId}/items/${itemId}");
    final Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${this.authToken}',
      },
    );
    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw "Can't get item.";
    }
  }

  Future<http.Response> create(Item item) {
    Uri url = Uri.http(_baseUrl, "/items");
    return http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${this.authToken}',
      },
      body: item.toJson(),
    );
  }

  Future<http.Response> delete(String id) {
    Uri url = Uri.http(_baseUrl, "/items/$id");
    return http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${this.authToken}',
      },
    );
  }
}
