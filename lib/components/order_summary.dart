import 'package:application/shared/purchases/format_currency.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final dynamic orderSummary;
  const OrderSummary({
    Key? key,
    required this.orderSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Resumo da compra',
          style: TextStyles.titleListTile,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.46,
              child: Text(
                'Items',
                style: TextStyles.buttonBoldHeading,
              ),
            ),
            SizedBox(
              width: size.width * 0.46,
              child: Text(
                getCurrency(orderSummary['totalItems']),
                style: TextStyles.buttonBoldHeading,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.46,
              child: Text(
                'Total desconto',
                style: TextStyles.buttonBoldHeading,
              ),
            ),
            SizedBox(
              width: size.width * 0.46,
              child: Text(
                getCurrency(orderSummary['totalDiscount']),
                style: TextStyles.buttonBoldHeading,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
