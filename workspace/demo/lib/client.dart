class Client {
  int id;
  String name;
  String direction;
  String email;
  String phone;

  Client({this.id, this.name, this.direction, this.email, this.phone});

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        name: json["name"],
        direction: json["direction"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "direction": direction,
        "email": email,
        "phone": phone,
      };
}
