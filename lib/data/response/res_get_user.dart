// To parse this JSON data, do
//
//     final resGetUser = resGetUserFromJson(jsonString);

import 'dart:convert';

List<ResGetUser> resGetUserFromJson(String str) =>
    List<ResGetUser>.from(json.decode(str).map((x) => ResGetUser.fromJson(x)));

String resGetUserToJson(List<ResGetUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResGetUser {
  ResGetUser({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  int? id;
  String? name;
  String? email;
  Gender? gender;
  Status? status;

  factory ResGetUser.fromJson(Map<String, dynamic> json) => ResGetUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: genderValues.map[json["gender"]]!,
        status: statusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": genderValues.reverse[gender],
        "status": statusValues.reverse[status],
      };
}

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"female": Gender.FEMALE, "male": Gender.MALE});

enum Status { INACTIVE, ACTIVE }

final statusValues =
    EnumValues({"active": Status.ACTIVE, "inactive": Status.INACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
