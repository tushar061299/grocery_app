import 'package:flutter/material.dart';
import 'package:grocery_app/models/pcproducts.dart';
import 'package:grocery_app/screens/pccategoryscreen.dart';

class PCCategoryCard extends StatelessWidget {
  const PCCategoryCard(
      {required this.label, required this.image, required this.pclist});

  final String label;
  final String image;
  final List<PCProduct> pclist;

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PCCategoryPage(pclist, label)));
      },
      child: Column(
        children: [
          Material(
            color: Colors.white,
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 65,
              width: x * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: sized_box_for_whitespace
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
