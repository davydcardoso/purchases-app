import 'dart:convert';

import 'package:application/components/alert_dialogs.dart';
import 'package:application/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> addAddressUser(
  BuildContext context,
  String userId,
  String address,
  String zipCode,
  String city,
) async {
  try {
    const String urlApi = applicationDevelopment ? urlDev : urlProd;

    final response = await http.post(
      Uri.parse("$urlApi/address/"),
      headers: {
        "content-type": "application/json",
      },
      body: {
        "usersId": userId,
        "address": address,
        "zipCode": zipCode,
        "complement": "null",
        "city": city,
        "district": "GO"
      },
    );

    final Map<String, dynamic> jsonMap = jsonDecode(response.body);

    switch (response.statusCode) {
      case 201 | 200:
        Navigator.pushReplacementNamed(
          context,
          '/login',
        );
        break;
      case 400:
        messageDialog(context, "Error", jsonMap['error']);
        break;
      default:
        messageDialog(context, "Error", jsonMap['error']);
        break;
    }
  } catch (ex) {
    messageDialog(context, "Error", ex.toString());
  }
}
