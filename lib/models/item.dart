class Item {
  final String id;
  final String name;
  final double price;
  final String imgUrl;
  final String description;

  Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.imgUrl,
      required this.description});

  static Item fromJson(Map<String, dynamic> json) => Item(
      id: json['id'].toString(),
      name: json['name'],
      price: double.parse(json['price']),
      imgUrl: json['image_url'] != null && json['image_url'] != ""
          ? json["image_url"]
          : "https://static.thenounproject.com/png/3734341-200.png",
      description: json['description'] != null ? json["description"] : "");

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'imgUrl': imgUrl != null || imgUrl != ""
            ? imgUrl
            : "https://static.thenounproject.com/png/3734341-200.png",
        'description': description
      };
}
