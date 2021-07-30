import 'package:flutter/material.dart';
import 'package:grocery_app/models/dbproducts.dart';
import 'package:grocery_app/screens/dbcategoryscreen.dart';

class DBCategoryCard extends StatelessWidget {
  const DBCategoryCard(
      {required this.label, required this.image, required this.mlist});

  final String label;
  final String image;
  final List<DBProduct> mlist;

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DBCategoryPage(mlist, label)));
      },
      child: Column(
        children: [
          Material(
            color: Colors.white,
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 65,
              width: x * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 30, child: Image.asset(image)),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 5),
                  // ignore: prefer_const_constructors
                  Text(label, style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
