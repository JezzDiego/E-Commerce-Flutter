import 'package:araplantas_mobile/models/adress.dart';

class User {
  String? name;
  String? phoneNumber;
  String? email;
  Adress? adress;

  User({this.name, this.phoneNumber, this.email, this.adress});

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        phoneNumber = json["phone"],
        email = json["email"],
        adress = json["addresses"] != null && json["addresses"].length > 0
            ? Adress.fromJson(json["addresses"][0] ?? [])
            : null;

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phoneNumber,
        "email": email,
        "adress": adress,
      };

  User.fromSnapshot(snapshot)
      : name = snapshot.data()["name"] != null
            ? snapshot.data()["name"]
            : snapshot.data()["displayName"],
        email = snapshot.data()["email"],
        phoneNumber = snapshot.data()["phone"],
        adress = snapshot.data()["addresses"] != null &&
                snapshot.data()["addresses"].length > 0
            ? Adress.fromJson(snapshot.data()["addresses"][0] ?? [])
            : null;
}
