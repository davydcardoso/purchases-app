import 'dart:convert';

import 'package:application/shared/auth/auth_controller.dart';
import 'package:flutter/material.dart';
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
}
