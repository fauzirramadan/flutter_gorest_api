// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.email,
    this.name,
    this.gender,
    this.status,
    this.id,
  });

  String? email;
  String? name;
  String? gender;
  String? status;
  int? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "gender": gender,
        "status": status,
        "id": id,
      };
}
