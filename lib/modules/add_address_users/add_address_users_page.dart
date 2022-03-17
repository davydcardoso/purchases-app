import 'package:flutter/material.dart';
import 'package:application/modules/add_address_users/components/body.dart';
import 'package:application/shared/themes/app_colors.dart';

class AddAddressUserPage extends StatefulWidget {
  const AddAddressUserPage({Key? key}) : super(key: key);

  @override
  State<AddAddressUserPage> createState() => _AddAddressUserPageState();
}

class _AddAddressUserPageState extends State<AddAddressUserPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Body(),
    );
  }
}
