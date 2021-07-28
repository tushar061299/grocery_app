import 'package:flutter/material.dart';
import 'package:grocery_app/auth/auth.dart';

class AuthProvider extends InheritedWidget {
  const AuthProvider(
      {required Key key, required Widget child, required this.auth})
      : super(key: key, child: child);
  final BaseAuth auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
