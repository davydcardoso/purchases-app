import 'package:application/components/alert_dialogs.dart';
import 'package:application/shared/purchases/purchases_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class MethodPaymentSelector extends StatelessWidget {
  const MethodPaymentSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final purchasesController = PurchasesController();

    return GestureDetector(
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
      child: FutureBuilder(
          future: purchasesController.getPaymentMethod(),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (snapshot.hasData) {
              return Container(
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
                  borderRadius: BorderRadius.all(Radius.circular(7)),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data['name'],
                            style: TextStyles.trailingRegular,
                          ),
                          Text(
                            '**** **** **** ' + snapshot.data['cardNumber'],
                            style: TextStyles.trailingRegular,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              messageDialog(context, "Erro", snapshot.error.toString());
            }

            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.heading,
              ),
            );
          }),
    );
  }
}
