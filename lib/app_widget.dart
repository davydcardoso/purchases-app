import 'package:application/modules/add_address_users/add_address_users_page.dart';
import 'package:application/modules/checkout/checkout_page.dart';
import 'package:application/modules/dashboard/dashboard_page.dart';
import 'package:application/modules/login/login_page.dart';
import 'package:application/modules/purchase_list/purchase_list.dart';
import 'package:application/modules/purchases/puchases_page.dart';
import 'package:application/modules/signup/signup_page.dart';
import 'package:application/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:application/shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppWidget() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
    }

    return MaterialApp(
      title: 'Mercado Quintal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/address-create': (context) => const AddAddressUserPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/purchases-home': (context) => const PurchasePage(),
        '/checkout': (context) => const CheckoutPage(),
        '/purchases-list': (context) => const PurchaseListPage(),
      },
    );
  }
}
