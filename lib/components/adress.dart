class Adress {
  final String zipCode;
  final String street;
  final String district;
  final String houseNumber;

  Adress(
      {required this.zipCode,
      required this.street,
      required this.district,
      required this.houseNumber});

  Map<String, dynamic> toJson() => {
        'zipCode': zipCode,
        'street': street,
        'district': district,
        'houseNumber': houseNumber
      };
}
