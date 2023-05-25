
import 'package:flutter/material.dart';


Widget textFild({
  required String hintTxt,
  required TextEditingController controller,
  bool isObs = false,
  TextInputType? keyBordType,
  TextInputAction? textInputAction,
  FocusNode? focusNode,
  String? errorText,
  required bool enabled,
  IconData? prefixIcon,
  String? validator
}) {
  return TextFormField(
    validator: (value) {
              if (value!.isEmpty) {
                return validator;
              }
              return null;
            },
    showCursor: true,
    focusNode: focusNode,
    textInputAction: textInputAction,
    autocorrect: false,
    controller: controller,
    textAlignVertical: TextAlignVertical.center,
    textAlign: TextAlign.start,
    obscureText: isObs,
    keyboardType: keyBordType,
    decoration: InputDecoration(
      label: Text(
        hintTxt,
        style: const TextStyle(
            fontFamily: 'Mulish',
            fontSize: 12,
            letterSpacing: 0.30000001192092896,
            fontWeight: FontWeight.normal,
            height: 1),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabled: enabled,
      errorText: errorText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      hintTextDirection: TextDirection.ltr,
    ),
  );
}

