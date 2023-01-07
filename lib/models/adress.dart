class Adress {
  final int id;
  final String zipCode;
  final String street;
  final String district;
  final String houseNumber;

  Adress(
      {required this.id,
      required this.zipCode,
      required this.street,
      required this.district,
      required this.houseNumber});

  Map<String, dynamic> toJson() => {
        'id': id,
        'zipCode': zipCode,
        'street': street,
        'district': district,
        'houseNumber': houseNumber
      };

  static Adress fromJson(Map<String, dynamic> json) {
    return Adress(
        id: json['id'],
        zipCode: json['zip_code'],
        street: json['street'],
        district: json['district'],
        houseNumber: json['house_number']);
  }
}
