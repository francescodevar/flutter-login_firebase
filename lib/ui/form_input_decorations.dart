import 'package:flutter/material.dart';

import 'constants.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    String? hintText,
    required Icon prefixIcon,
    Icon? suffixicon,
  }) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 1),
        hintText: hintText,
        suffix: suffixicon,
        filled: true,
        fillColor: const Color(0xff1A2D42),
        hintStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: TextStyle(color: companyColor),
        prefixIcon: prefixIcon,
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? companyColor
                : Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: backgroundColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: companyColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(4),
        ));
  }
}
