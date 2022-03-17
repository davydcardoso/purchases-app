import 'package:flutter/material.dart';
import 'package:application/shared/auth/auth_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    authController.verifyUserSession(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              AppImages.logoMercado,
              width: size.width,
              height: 200,
            ),
          )
        ],
      ),
    );
  }
}
