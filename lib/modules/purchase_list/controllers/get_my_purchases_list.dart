import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:application/constants.dart';
import 'package:application/shared/auth/auth_controller.dart';
import 'package:application/components/alert_dialogs.dart';

Future<List<dynamic>> getMyPurchasesList(BuildContext context) async {
  try {
    final authController = AuthController();

    final user = await authController.getUserSession();

    const String urlApi = applicationDevelopment ? urlDev : urlProd;
    final String credentials = user.token;

    final response = await http.get(
      Uri.parse('$urlApi/purchases/my-list'),
      headers: {'authorization': 'Basic $credentials'},
    );

    Map<String, dynamic> json = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        return json['purchases'];
      default:
        return json['purchases'];
    }
  } catch (e) {
    messageDialog(context, 'Erro', e.toString());
    rethrow;
  }
}
