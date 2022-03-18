import 'package:application/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardTemplate extends StatelessWidget {
  const CardTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 50,
      height: 200,
      decoration: const BoxDecoration(
        color: AppColors.subtleBlue,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.subtleBlue,
            AppColors.primary,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark,
            offset: Offset(1.0, 1.0),
            blurRadius: 6.0,
          )
        ],
      ),
    );
  }
}
