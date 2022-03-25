import 'dart:convert';

class PurchaseOrderList {
  final String id;
  final int status;
  final String purchaseDate;
  final double purchaseTotal;
  final String fullName;
  final String phoneNumber;
  final String paymentMethod;

  PurchaseOrderList({
    required this.id,
    required this.status,
    required this.purchaseDate,
    required this.purchaseTotal,
    required this.fullName,
    required this.phoneNumber,
    required this.paymentMethod,
  });

  factory PurchaseOrderList.fromMap(Map<String, dynamic> jsonMap) {
    return PurchaseOrderList(
      id: jsonMap['id'],
      status: jsonMap['status'] as int,
      purchaseDate: jsonMap['purchaseDate'],
      purchaseTotal: double.parse(jsonMap['purchaseTotal'].toString()),
      fullName: jsonMap['fullName'],
      phoneNumber: jsonMap['phoneNumber'],
      paymentMethod: jsonMap['paymentMethod'],
    );
  }

  factory PurchaseOrderList.fromJson(String json) =>
      PurchaseOrderList.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "purchaseDate": purchaseDate,
        "purchaseTotal": purchaseTotal,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "paymentMethod": paymentMethod,
      };

  String toJson() => jsonEncode(toMap());
}
