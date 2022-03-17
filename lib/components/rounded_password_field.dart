import 'package:flutter/material.dart';
import 'package:application/components/text_field_container.dart';
import 'package:application/shared/themes/app_colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        decoration: const InputDecoration(
          hintText: "Digite sua senha",
          icon: Icon(
            Icons.lock,
            color: AppColors.primary,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: AppColors.primary,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
