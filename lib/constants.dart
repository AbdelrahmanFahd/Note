import 'package:flutter/material.dart';

InputDecoration cTextFormFieldDecoration(String textField, double fontSize) {
  return InputDecoration(
    // fillColor: const Color(0xffF3F6FD),
    fillColor: Colors.grey[800],
    filled: true,
    focusedBorder: OutlineInputBorder(
      gapPadding: 1.0,
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      gapPadding: 1.0,
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(25),
    ),
    hintText: textField,
    hintStyle: TextStyle(
      fontSize: fontSize,
      color: Colors.grey[400],
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      gapPadding: 1.0,
      borderRadius: BorderRadius.circular(25),
    ),
  );
}
