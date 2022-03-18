// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class DrawerDashboard extends StatefulWidget {
  const DrawerDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerDashboard> createState() => _DrawerDashboardState();
}

class _DrawerDashboardState extends State<DrawerDashboard> {
  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Drawer(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(
              params['name'] as String,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
            accountEmail: new Text(
              'email@test.com',
              style: new TextStyle(
                color: Colors.blueGrey[50],
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.brown,
              child: Text("FL"),
            ),
          )
        ],
      ),
    );
  }
}
