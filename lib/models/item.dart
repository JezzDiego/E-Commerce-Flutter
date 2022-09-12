// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    this.id,
    this.name,
    this.price,
    this.imgUrl,
    this.description,
  });

  String? id;
  String? name;
  double? price;
  String? imgUrl;
  String? description;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "imgUrl": imgUrl == null ? null : imgUrl,
        "description": description == null ? null : description,
      };
}
