import 'package:flutter/material.dart';

class CustomColors {
  // ignore: constant_identifier_names
  static const Color AppbarColor = Color(0xFF3A5160);
  // ignore: constant_identifier_names
  static const Color LightGreen = Color(0xffc3ffba);
  // ignore: constant_identifier_names
  static const Color DarkGreen = Color(0xff52b53d);
  // ignore: constant_identifier_names
  static const Color LightOrange = Color(0xffFFE8E7);
  // ignore: constant_identifier_names
  static const Color DarkOrange = Color(0xfff88a77);
}

class CustomTextStyles {
  // ignore: constant_identifier_names
  static const TextStyle AppbarText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white);
  // ignore: constant_identifier_names
  static const TextStyle FVATCText = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: CustomColors.DarkGreen);
  // ignore: constant_identifier_names
  static const TextStyle FDATCText = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xff918ae2));
  // ignore: constant_identifier_names
  static const TextStyle CRText =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.red);
  // ignore: constant_identifier_names
  static const TextStyle MATCText = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: CustomColors.DarkOrange);
  // ignore: constant_identifier_names
  static const TextStyle FCText1 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white);
  // ignore: constant_identifier_names
  static const TextStyle FCText2 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70);
  // ignore: constant_identifier_names
  static const TextStyle FCText3 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);
}
