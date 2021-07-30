import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.black87,
            height: 100.0,
            width: x,
            // ignore: prefer_const_constructors
            child: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(top: 60, left: 20),
              // ignore: prefer_const_constructors
              child: Text('The Grocery', style: CustomTextStyles.AppbarText),
            ),
          ),
          // ignore: prefer_const_constructors
          DrawerTile(
            label: 'Account',
          ),
          // ignore: prefer_const_constructors
          DrawerTile(label: 'My Orders'),
          // ignore: prefer_const_constructors
          DrawerTile(label: 'Payments'),
          // ignore: prefer_const_constructors
          DrawerTile(label: 'Terms & Conditions'),
          // ignore: prefer_const_constructors
          DrawerTile(label: 'Contact Us'),
          // ignore: prefer_const_constructors
          DrawerTile(label: 'About Us'),
          // ignore: prefer_const_constructors
          Spacer(),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: DrawerTile(
                label: 'Logout',
                onPress: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.label,
    this.onPress,
  }) : super(key: key);

  final String label;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      // ignore: sized_box_for_whitespace
      child: Container(
        height: 45,
        child: Center(
            child: Row(
          children: [
            // ignore: prefer_const_constructors
            SizedBox(width: 40),
            // ignore: prefer_const_constructors
            Text(
              label,
              // ignore: prefer_const_constructors
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        )),
      ),
    );
  }
}
