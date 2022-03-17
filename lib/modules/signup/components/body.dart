import 'package:application/components/already_have_an_account_acheck.dart';
import 'package:application/components/rounded_button.dart';
import 'package:application/components/rounded_input_field.dart';
import 'package:application/components/rounded_password_field.dart';
import 'package:application/modules/signup/controllers/signup_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final signUpController = SignUpController();
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height * 0.30,
              color: AppColors.grey,
            ),
            Positioned(
              top: 55.0,
              left: 0.0,
              right: 0.0,
              child: Image.asset(
                AppImages.logoMercado,
                width: size.width,
                height: 200,
              ),
            ),
            Positioned(
              bottom: size.height * 0.10,
              left: 0.0,
              right: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Digite seu Nome",
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "Digite seu E-mail",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedButton(
                    text: "Proximo",
                    press: () async {
                      await signUpController.signUp(
                        context,
                        name,
                        email,
                        password,
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
