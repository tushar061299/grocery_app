import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AuthTextField({
    required this.tController,
    required this.hintText,
    required this.validate,
    required this.t,
  });

  final TextEditingController tController;
  final String hintText;
  final Function? validate;
  final bool t;

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    // ignore: sized_box_for_whitespace
    return Container(
      height: x * 0.106,
      width: x * 0.7,
      child: TextFormField(
        obscureText: t,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          // ignore: prefer_const_constructors
          hintText: hintText,
          hintStyle: GoogleFonts.lato(
            fontSize: 20.0,
            // ignore: prefer_const_constructors
            color: Color.fromRGBO(00, 44, 64, 1),
          ),
          // ignore: prefer_const_constructors
          contentPadding: EdgeInsets.only(bottom: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1.8,
            ),
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
        controller: tController,
        //validator: validate,
      ),
    );
  }
}
