import 'package:application/components/card_template.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class HomePageDashboard extends StatefulWidget {
  const HomePageDashboard({Key? key}) : super(key: key);

  @override
  State<HomePageDashboard> createState() => _HomePageDashboardState();
}

class _HomePageDashboardState extends State<HomePageDashboard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.background,
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.03),
          Text('Meus Cartões', style: TextStyles.titleCardBold),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CardTemplate(),
            ],
          )
        ],
      ),
    );
  }
}
