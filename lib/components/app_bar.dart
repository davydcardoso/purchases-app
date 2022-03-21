import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBarApp extends StatelessWidget {
  final String username;
  final VoidCallback onPressFunction;
  const AppBarApp({
    Key? key,
    required this.username,
    required this.onPressFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: onPressFunction,
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.stroke,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
