import 'dart:convert';
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
      // final String credentiais = "$email:$pass";
      // // Codec<String, String> stringToBase64 = utf8.fuse(base64);
      // // print("$urlApi/users/signin");
      // String base64Credentials = stringToBase64.encode(credentiais);
      final response = await http.post(
          Uri.parse(
              'http://api.rocketzapi.com.br:3002/odin/v1/sessions/signin'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // 'Authorization': 'Basic $basicCredentials'
            // 'Authorization': 'Basic bGJneW5AbG9qYWRvYm9ycmFjaGVpcm8uY29tLmJyOjgyNDY1Nw=='
          },
          body: {
            "email": email,
            "password": password,
          });

      print(response.statusCode);

      switch (response.statusCode) {
        case 403:
          await _showMyDialog(
            context,
            'Erro',
            'Usuario não localizado...\nEmail ou senha invalidos',
            'Ok',
          );
          break;
        case 200:
          // Map<String, dynamic> sessionResponseApi = jsonDecode(response.body);
          final user = UserModel.fromJson(response.body);
          authController.setUser(context, user);
          break;
        case 400:
          await _showMyDialog(
            context,
            'Erro',
            response.body.toString(),
            'Ok',
          );
          break;
        default:
          await _showMyDialog(
            context,
            'Erro',
            response.body.toString(),
            'Ok',
          );
          break;
      }
    } catch (ex) {
      await _showMyDialog(
        context,
        'Erro',
        ex.toString(),
        'Ok',
      );
    }
  }

  Future<void> _showMyDialog(
    BuildContext context,
    String titleMessage,
    String messageBody,
    String buttonText,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(titleMessage),
                Text(messageBody),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
