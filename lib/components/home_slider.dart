import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    required this.imageArray,
  });

  final List imageArray;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        aspectRatio: 1.0,
      ),
      itemCount: imageArray.length,
      itemBuilder: (context, index, _) {
        return Container(
          // ignore: prefer_const_constructors
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              imageArray[index],
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
