class User {
  String? name;
  String? phoneNumber;
  String? email;
  bool isAdmin;

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "isAdmin": isAdmin
      };

  User.fromSnapshot(snapshot)
      : name = snapshot.data()["name"],
        email = snapshot.data()["email"],
        phoneNumber = snapshot.data()["phoneNumber"],
        isAdmin = snapshot.data()["isAdmin"];
}
