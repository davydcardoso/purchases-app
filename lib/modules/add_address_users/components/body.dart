import 'package:flutter/material.dart';
import 'package:application/modules/add_address_users/controllers/add_address_user_controller.dart';
import 'package:application/shared/themes/app_images.dart';
import 'package:application/components/rounded_button.dart';
import 'package:application/components/rounded_input_field.dart';
import 'package:application/shared/themes/app_colors.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String usersId = '';
  String address = '';
  String zipCode = '';
  String city = '';

  @override
  Widget build(BuildContext context) {
    final routesParams =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    usersId = routesParams['userId'] as String;

    print(routesParams);

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
                    hintText: "Seu endereço",
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "Seu CEP",
                    onChanged: (value) {
                      zipCode = value;
                    },
                  ),
                  RoundedInputField(
                    hintText: "Sua cidade",
                    onChanged: (value) {
                      city = value;
                    },
                  ),
                  RoundedButton(
                    text: "Criar Conta",
                    press: () async {
                      await addAddressUser(
                        context,
                        usersId,
                        address,
                        zipCode,
                        city,
                      );
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
