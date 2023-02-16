import 'package:flutter/material.dart';
import 'globals.dart';

class Styles {

  static TextStyle headingStyle1({Color color = Colors.black}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: 30,
    );
  }

  static TextStyle headingStyle2({Color color = Globals.dark}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
  }

  static TextStyle headingStyle3({Color color = Globals.dark}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
  }

  static TextStyle headingStyle4(
      {Color color = Globals.dark, bool isBold = false}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
    );
  }

  static TextStyle headingStyle5(
      {Color color = Globals.dark, bool strike = false, bool isBold = false,double? fontSize}) {
    return TextStyle(
      color: color,
      fontSize: fontSize??14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
      decorationThickness: strike ? 1.5 : 0,
    );
  }

  static TextStyle headingStyle6(
      {Color color = Globals.dark, bool isBold = false, bool strike = false}) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static TextStyle headingStyle7({
    Color color = Globals.dark,
    bool isBold = false,
    bool strike = false,
    bool underline = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
      decoration: strike
          ? TextDecoration.lineThrough
          : underline
          ? TextDecoration.underline
          : TextDecoration.none,
    );
  }

  static TextStyle headingStyle8(
      {Color color = Globals.dark, bool isBold = false, bool strike = false}) {
    return TextStyle(
      color: color,
      fontSize: 7,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static TextStyle buttonStyle() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  static InputDecoration requestFormFieldStyle({
    String labelText = '',
    IconData? suffixIconData,
    Function? onPressed,
    bool showVerify = false,
  }) {
    return InputDecoration(
      labelStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      hintStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1.15, color: Colors.grey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      counterText: "",
      labelText: "$labelText\t",
      suffixIconConstraints: const BoxConstraints(maxWidth: 50),
      suffixIcon: Container(
        alignment: Alignment.center,
        child: Icon(
          suffixIconData,
          size: 25,
          color: Colors.green,
        ),
      )
    );
  }

}
