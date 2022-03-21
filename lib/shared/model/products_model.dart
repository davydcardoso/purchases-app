import 'dart:convert';

class ProductsModel {
  final String id;
  final String name;
  final String description;
  late double value;
  final double discount;
  late int totalItems;
  final String? image;

  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.value,
    required this.discount,
    this.totalItems = 0,
    this.image,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> jsonMap) {
    return ProductsModel(
      id: jsonMap['id'],
      name: jsonMap['name'],
      description: jsonMap['description'],
      value: jsonMap['value'],
      discount: jsonMap['discount'],
      image: jsonMap['image'],
      totalItems: jsonMap['totalItems'] ?? 0,
    );
  }

  factory ProductsModel.fromJson(String json) =>
      ProductsModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "value": value,
        "discount": discount,
        "image": image,
        "totalItems": totalItems
      };

  String toJson() => jsonEncode(toMap());
}
