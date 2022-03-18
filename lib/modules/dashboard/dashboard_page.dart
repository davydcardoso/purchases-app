import 'package:application/modules/dashboard/components/drawer.dart';
import 'package:application/modules/dashboard/controllers/index_page_controller.dart';
import 'package:application/shared/themes/app_colors.dart';
import 'package:application/shared/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final pageController = PageIndexController();
  final pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        drawer: const DrawerDashboard(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
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
                        text: params['name'],
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
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: pages[pageController.currentPage],
        bottomNavigationBar: Container(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    pageController.setPage(0);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.home,
                    color: AppColors.primary,
                  )),
              GestureDetector(
                onTap: () {
                  print('Clicou');
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  pageController.setPage(1);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.description_outlined,
                  color: AppColors.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
