import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBarApp extends StatelessWidget {
  final String username;
  const AppBarApp({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      color: AppColors.primary,
      child: Center(
        child: ListTile(
          title: Text.rich(
            TextSpan(
              text: "Olá, ",
              style: TextStyles.titleRegular,
              children: [
                TextSpan(
                  text: username,
                  style: TextStyles.titleBoldBackground,
                )
              ],
            ),
          ),
          subtitle: Text(
            'Mercado Quintal',
            style: TextStyles.captionShape,
          ),
          trailing: GestureDetector(
            onTap: () {
              // Scaffold.of(context).openDrawer();
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_basket_outlined,
                      color: AppColors.background,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
