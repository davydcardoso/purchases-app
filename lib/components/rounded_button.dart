import 'package:flutter/material.dart';
import 'package:application/shared/themes/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double? width;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark,
            offset: Offset(0.1, 0.1),
            blurRadius: 6.0,
          )
        ],
      ),
      width: width ?? size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
