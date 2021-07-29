import 'package:flutter/material.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:topica/screens/fvcategorypage.dart';


class FVCategoryCard extends StatelessWidget {
  const FVCategoryCard({
    required this.label,
    required this.image,
    required this.fvlist,
  });

  final String label;
  final String image;
  final List<FVProduct> fvlist;

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FVCategoryPage(fvlist,label)));
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          height: x*0.33,
          width: x*0.35,
          child: Column(
            children: [
              Container(
                width: x*0.25,
                child: Image.asset(image),
              ),
              SizedBox(height: 10),
              Text(label,style: TextStyle(fontSize: 16.5,fontWeight: FontWeight.w500)),
            ],
          ),

        ),
      ),
    );
  }
}