import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String token;

  UserModel({
    required this.token,
    required this.name,
    required this.id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['user']['name'],
      id: map['user']['id'],
      token: map['token'],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  // factory UserModel.toModel() {
  //   return UserModel(name: name, company: '', email: '', token: '');
  // }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "token": token,
      };

  String toJson() => jsonEncode(toMap());
}
