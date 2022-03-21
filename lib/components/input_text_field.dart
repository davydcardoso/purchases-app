import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final int maxLines;
  final ValueChanged<String> onChanged;
  const InputTextField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: onChanged,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: hintText,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
