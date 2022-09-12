class Adress {
  Adress({
    this.id,
    this.zipCode,
    this.district,
    this.houseNumber,
    this.street,
  });

  String? id;
  String? zipCode;
  String? district;
  String? houseNumber;
  String? street;

  factory Adress.fromJson(Map<String, dynamic> json) => Adress(
        id: json["id"] == null ? null : json["id"],
        zipCode: json["zipCode"] == null ? null : json["zipCode"],
        district: json["district"] == null ? null : json["district"],
        houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
        street: json["street"] == null ? null : json["street"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "zipCode": zipCode == null ? null : zipCode,
        "district": district == null ? null : district,
        "houseNumber": houseNumber == null ? null : houseNumber,
        "street": street == null ? null : street,
      };
}
