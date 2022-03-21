import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const bool applicationDevelopment = true;
const String urlDev = "http://7971-168-195-132-41.ngrok.io/api";
const String urlProd = "http://localhost:3000/api";

final maskPhoneNumber = MaskTextInputFormatter(
  mask: '+## (##) #.####-####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
