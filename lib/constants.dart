import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const bool applicationDevelopment = true;
const String urlDev = "http://192.168.3.3:3001/api";
const String urlProd = "http://localhost:3000/api";

final maskPhoneNumber = MaskTextInputFormatter(
  mask: '+## (##) #.####-####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
