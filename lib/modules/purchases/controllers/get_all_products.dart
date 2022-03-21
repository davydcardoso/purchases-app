import 'dart:convert';

import 'package:application/constants.dart';
import 'package:application/shared/purchases/purchases_controller.dart';
import 'package:application/shared/auth/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:application/shared/model/products_model.dart';

Future<List<ProductsModel>> getAllProducts() async {
  final authController = AuthController();
  final purchasesController = PurchasesController();

  final user = await authController.getUserSession();

  const String urlAPI = applicationDevelopment ? urlDev : urlProd;
  final bearerToken = user.token;

  final response = await http.get(
    Uri.parse('$urlAPI/products/'),
    headers: {'authorization': 'Bearer $bearerToken'},
  );

  List<ProductsModel> listProducts = [];

  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<dynamic> arrayProducts = jsonMap['products'];

      for (var products in arrayProducts) {
        final itemCount = await purchasesController.getItem(
          products['id'] as String,
        );

        listProducts.add(ProductsModel(
          id: products['id'],
          name: products['name'],
          description: products['description'],
          value: products['value'],
          discount: products['discount'],
          image: products['image'],
          totalItems: itemCount,
        ));
      }

      return listProducts;
    default:
      return listProducts;
  }
}
