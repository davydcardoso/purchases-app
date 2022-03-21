import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

messageDialog(BuildContext context, String title, String message) {
  return Dialogs.materialDialog(
    msg: message,
    title: title,
    color: Colors.white,
    context: context,
    actions: [
      IconsButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: "OK",
        iconData: Icons.check_circle,
        color: Colors.blue,
        textStyle: const TextStyle(color: Colors.white),
        iconColor: Colors.white,
      ),
    ],
  );
}

messageConfirmation(
  BuildContext context,
  String title,
  String message,
  VoidCallback onPressCancel,
  VoidCallback onPressOK,
) {
  return Dialogs.materialDialog(
    msg: message,
    title: title,
    color: Colors.white,
    context: context,
    actions: [
      IconsOutlineButton(
        onPressed: onPressCancel,
        text: 'Cancelar',
        iconData: Icons.cancel_outlined,
        textStyle: const TextStyle(color: Colors.grey),
        iconColor: Colors.grey,
      ),
      IconsButton(
        onPressed: onPressOK,
        text: 'Continuar',
        iconData: Icons.check,
        color: Colors.blue,
        textStyle: const TextStyle(color: Colors.white),
        iconColor: Colors.white,
      ),
    ],
  );
}
