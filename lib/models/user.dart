// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:araplantas_mobile/models/adress.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.isAdmin,
    this.adress,
  });

  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  bool? isAdmin;
  Adress? adress;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        adress: json["adress"] == null ? null : Adress.fromJson(json["adress"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "adress": adress == null ? null : adress?.toJson(),
      };
}
