import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application/shared/model/user_model.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
        arguments: {
          'token': user.token,
          'name': user.name,
          'id': user.id,
        },
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('token', user.token);
    await instance.setString('name', user.name);
    await instance.setString('id', user.id);
    return;
  }

  Future<void> verifyUserSession(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 2));

    if (instance.containsKey('token')) {
      final token = instance.get('token') as String;
      final name = instance.get('name') as String;
      final id = instance.get('id') as String;

      final user = UserModel(
        name: name,
        token: token,
        id: id,
      );

      setUser(context, user);
      return;
    }

    setUser(context, null);
  }

  Future<void> singOut(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('token');
    await instance.remove('name');
    await instance.remove('id');

    Navigator.pushReplacementNamed(context, '/login');
    return;
  }
}
