import 'dart:ffi';

import 'package:application/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarApp extends StatelessWidget {
  final VoidCallback pressButtonHome;
  final VoidCallback pressButtonList;
  const BottomNavigationBarApp({
    Key? key,
    required this.pressButtonHome,
    required this.pressButtonList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              onPressed: pressButtonHome,
              icon: const Icon(
                Icons.home,
                color: AppColors.primary,
              )),
          GestureDetector(
            onTap: () {},
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
            onPressed: pressButtonList,
            icon: const Icon(
              Icons.description_outlined,
              color: AppColors.body,
            ),
          ),
        ],
      ),
    );
  }
}
