import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String image;
  final Function onpress;
  HomeCard({required this.title, required this.image, required this.onpress});

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onpress,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        child: Container(
          height: x * 0.4,
          width: x * 0.4,
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: Container(
                  height: x / 3.4,
                  width: x / 3.4,
                  margin: EdgeInsets.only(bottom: 6, top: 12),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 25,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
