import 'package:application/components/app_bar.dart';
import 'package:application/components/bottom_navigation_bar.dart';
import 'package:application/modules/dashboard/components/drawer.dart';
import 'package:application/modules/purchases/controllers/index_page_controller.dart';
import 'package:flutter/material.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final pageController = PageIndexController();

  final pages = [
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.blue,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
          drawer: DrawerDashboard(
            isAdmin: params['isAdmin'] as bool,
            username: params['name'] as String,
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBarApp(username: params['name']),
          ),
          body: pages[pageController.currentPage],
          bottomNavigationBar: BottomNavigationBarApp(
            pressButtonHome: () {
              pageController.setPage(0);
              setState(() {});
            },
            pressButtonList: () {
              pageController.setPage(1);
              setState(() {});
            },
          )),
    );
  }
}
