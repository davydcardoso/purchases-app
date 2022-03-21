import 'dart:convert';
import 'package:application/components/alert_dialogs.dart';
import 'package:application/constants.dart';
import 'package:http/http.dart' as http;
import 'package:application/shared/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application/shared/model/products_model.dart';

class PurchasesController {
  final authController = AuthController();

  Future<void> createShoppingCart(
    BuildContext context,
    List<ProductsModel> productsCart,
  ) async {
    final instance = await SharedPreferences.getInstance();
    final user = await authController.getUserSession();

    List<ProductsModel> products = [];

    for (var i = 0; i < productsCart.length; i++) {
      if (productsCart[i].totalItems > 0) {
        products.add(productsCart[i]);
      }
    }

    for (var i = 0; i < products.length; i++) {
      products[i].totalItems = await getItem(products[i].id);
      products[i].value =
          (products[i].value * products[i].totalItems) - products[i].discount;
    }

    final productJsonArray = jsonEncode(products);

    await instance.setString('products.cart', productJsonArray);

    Navigator.popAndPushNamed(
      context,
      '/checkout',
      arguments: {
        'name': user.name,
        'isAdmin': user.isAdmin,
      },
    );
  }

  Future<void> finallyPurchaseOrder(
    BuildContext context,
    String userName,
    String phoneNumber,
    String email,
    String address,
    String promotionalCode,
    String informationOrder,
  ) async {
    try {
      final authController = AuthController();
      final user = await authController.getUserSession();

      late double totalProducts = 0.00;
      late double totalDiscount = 0.00;

      const String urlApi = applicationDevelopment ? urlDev : urlProd;
      final String credentials = user.token;
      final products = await getShoppingCart();
      List<Map<String, dynamic>> productJson = [];

      for (var product in products) {
        productJson.add(jsonDecode(product));
      }

      for (var i = 0; i < productJson.length; i++) {
        totalProducts = totalProducts + productJson[i]['value'];
        totalDiscount = totalDiscount + productJson[i]['discount'];
      }

      totalProducts = totalProducts - totalDiscount;

      var newFormat = DateFormat("yyyy-MM-dd");
      String updatedDt = newFormat.format(DateTime.now());

      final response = await http.post(
        Uri.parse('$urlApi/purchases/'),
        headers: {'authorization': 'Basic $credentials'},
        body: jsonEncode(
          {
            'purchaseDate': updatedDt,
            'purchaseTotal': totalProducts,
            'fullName': userName,
            'phoneNumber': phoneNumber,
            'email': email,
            'paymentMethod': 'credit_card',
            'promotionalCode': promotionalCode,
            'orderComments': informationOrder,
            'products': productJson,
          },
        ),
      );

      switch (response.statusCode) {
        case 201:
          messageDialog(
            context,
            'Compra realizada',
            'Compra realizada com sucesso!',
          );

          Navigator.pushReplacementNamed(
            context,
            '/dashboard',
            arguments: {
              'isAdmin': user.isAdmin,
              'token': user.token,
              'name': user.name,
              'id': user.id,
            },
          );
          break;
        default:
          Map<String, dynamic> jsonMap = jsonDecode(response.body);
          messageDialog(
            context,
            'Compra não realizada',
            jsonMap['error'],
          );

          break;
      }
    } catch (ex) {
      messageDialog(context, 'Erro', ex.toString());
    }
  }

  Future<List<dynamic>> getShoppingCart() async {
    final instance = await SharedPreferences.getInstance();

    final String? productsSalved = instance.getString('products.cart');

    if (productsSalved != null) {
      List<dynamic> products = jsonDecode(productsSalved);

      return products;
    }

    return [];
  }

  Future<dynamic> getOrderSummary() async {
    final instance = await SharedPreferences.getInstance();

    final String? productsSalved = instance.getString('products.cart');
    late double totalItems = 0.00;
    late double totalDiscount = 0.00;

    if (productsSalved != null) {
      List<dynamic> products = jsonDecode(productsSalved);
      for (var i = 0; i < products.length; i++) {
        ProductsModel product = ProductsModel.fromJson(
          products[i],
        );

        totalItems = totalItems + product.value;
        totalDiscount = totalDiscount = product.discount;
      }
    }

    return {'totalItems': totalItems, 'totalDiscount': totalDiscount};
  }

  Future<int> getItem(String itemId) async {
    final instance = await SharedPreferences.getInstance();

    int? item = instance.getInt('item.cart-$itemId');

    if (item != null) {
      return item;
    }

    return 0;
  }

  Future<void> removeItem(String itemId) async {
    final instance = await SharedPreferences.getInstance();

    int? itemOld = instance.getInt('item.cart-$itemId');

    if (itemOld != null) {
      itemOld--;
      await instance.setInt('item.cart-$itemId', itemOld);
      return;
    }

    await instance.setInt('item.cart-$itemId', 1);
  }

  Future<void> addItem(String itemId) async {
    final instance = await SharedPreferences.getInstance();

    late int? itemOld = instance.getInt('item.cart-$itemId');

    if (itemOld != null) {
      itemOld++;
      await instance.setInt('item.cart-$itemId', itemOld);
      return;
    }

    await instance.setInt('item.cart-$itemId', 1);
  }

  Future<dynamic> getPaymentMethod() async {
    final instance = await SharedPreferences.getInstance();

    final String? paymentMethod = instance.getString('user.payment-method');

    if (paymentMethod != null) {
      List<dynamic> paymentMethodJson = jsonDecode(paymentMethod);

      for (var i = 0; i < paymentMethodJson.length; i++) {
        if (paymentMethodJson[i]['isDefault']) {
          return {
            'name': paymentMethodJson[i]['name'],
            'cardNumber': paymentMethodJson[i]['cardNumber'],
          };
        }
      }
    }

    return {};
  }
}
