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
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imgUrl: json['imgUrl'],
      description: json['description']);
}
