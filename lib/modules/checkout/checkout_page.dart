import 'package:application/components/alert_dialogs.dart';
import 'package:application/components/app_bar.dart';
import 'package:application/components/drawer.dart';
import 'package:application/components/input_text_field.dart';
import 'package:application/components/input_text_formated_field.dart';
import 'package:application/components/order_summary.dart';
import 'package:application/components/rounded_button.dart';
import 'package:application/constants.dart';
import 'package:application/modules/checkout/components/products_cart.dart';
import 'package:application/shared/purchases/purchases_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final purchasesController = PurchasesController();

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;

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
          preferredSize: const Size.fromHeight(75),
          child: AppBarApp(
            username: params['name'],
            onPressFunction: () {},
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 10, bottom: 15),
          children: <Widget>[
            ProductsCartCheckout(size: size),
            Container(
              padding: const EdgeInsets.only(top: 5),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Informações de Contato',
                    style: TextStyles.titleListTile,
                  ),
                  InputTextField(
                    hintText: 'Nome de usuario',
                    onChanged: (value) {},
                  ),
                  InputTextFormatedField(
                    hintText: 'Seu numero',
                    onChanged: (value) {},
                    maskText: maskPhoneNumber,
                  ),
                  InputTextField(
                    hintText: 'E-mail',
                    onChanged: (value) {},
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Endereço Completo',
                          style: TextStyles.titleListTile,
                        ),
                        InputTextField(
                          maxLines: 8,
                          hintText: '',
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Metodo de Pagamento',
                          style: TextStyles.titleListTile,
                        ),
                        GestureDetector(
                          onTap: () {
                            messageConfirmation(
                              context,
                              'Checkout',
                              'Deseja alterar o metodo de pagamento?',
                              () {
                                Navigator.pop(context);
                              },
                              () {},
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              left: 20,
                              top: 8,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.background,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.dark,
                                  offset: Offset(0.1, 0.1),
                                  blurRadius: 3.0,
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.credit_card,
                                  size: 50,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Master Card',
                                        style: TextStyles.trailingRegular,
                                      ),
                                      Text(
                                        '**** **** **** 1234',
                                        style: TextStyles.trailingRegular,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Codigo Promocional',
                              style: TextStyles.titleListTile,
                            ),
                            InputTextField(
                              hintText: 'Codigo promocional',
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Observações do pedido',
                                style: TextStyles.titleListTile,
                              ),
                              InputTextField(
                                maxLines: 8,
                                hintText: '',
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: FutureBuilder(
                            future: purchasesController.getOrderSummary(),
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<dynamic> snapshot,
                            ) {
                              if (snapshot.hasData) {
                                return OrderSummary(
                                  orderSummary: snapshot.data,
                                );
                              }

                              if (snapshot.hasError) {
                                messageDialog(
                                  context,
                                  "Erro",
                                  snapshot.error.toString(),
                                );
                              }

                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.heading,
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RoundedButton(
                              width: size.width * 0.93,
                              text: 'Finalizar compra',
                              press: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
