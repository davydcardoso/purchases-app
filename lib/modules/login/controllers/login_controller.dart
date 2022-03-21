import 'dart:convert';
import 'package:application/components/alert_dialogs.dart';
import 'package:application/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:application/shared/auth/auth_controller.dart';
import 'package:application/shared/model/user_model.dart';

class LoginController {
  Future<void> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    final authController = AuthController();
    try {
      const String urlApi = applicationDevelopment ? urlDev : urlProd;
      final String credentiais = "$email:$password";

      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String base64Credentials = stringToBase64.encode(credentiais);

      final response = await http.post(
        Uri.parse('$urlApi/users/singin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Basic $base64Credentials'
        },
      );

      final Map<String, dynamic> jsonMap = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          final user = UserModel.fromJson(response.body);
          authController.saveMethodPaymentsUser(
            jsonMap['user']['paymentsMethods'],
          );
          authController.setUser(context, user);
          break;
        case 400:
          messageDialog(context, "Error", jsonMap['error']);
          break;
        default:
          messageDialog(context, "Error", jsonMap['error']);
          break;
      }
    } catch (ex) {
      messageDialog(context, 'Erro', ex.toString());
    }
  }
}
