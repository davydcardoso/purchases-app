import 'dart:convert';
import 'package:application/components/alert_dialogs.dart';
import 'package:application/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpController {
  Future<void> signUp(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    try {
      const String urlApi = applicationDevelopment ? urlDev : urlProd;

      final response = await http.post(
        Uri.parse("$urlApi/users/"),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": password
        }),
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);

      switch (response.statusCode) {
        case 201:
          final userId = jsonMap['userId'] as String;

          Navigator.pushReplacementNamed(
            context,
            '/address-create',
            arguments: {'userId': userId},
          );
          break;
        default:
          messageDialog(context, "Error", jsonMap['error'] as String);
          break;
      }
    } catch (ex) {
      print(ex.toString());
      messageDialog(context, 'Erro', ex.toString());
    }
  }
}
