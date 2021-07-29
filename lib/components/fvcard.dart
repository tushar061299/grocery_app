import 'package:flutter/material.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:grocery_app/screens/fruitdetails.dart';

class FVCard extends StatelessWidget {
  const FVCard({
    required this.fvlist,
  });
  final List<FVProduct> fvlist;
  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetectMain(fvlist)));
      },
      child: Row(
        children: [
          Expanded(
            child: Material(
              // ignore: prefer_const_constructors
              color: Color(0xff52b53d),
              elevation: 1,
              borderRadius: BorderRadius.circular(8),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: y*0.208,
                child: Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.only(top: 25,left: 15,bottom: 5),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                // ignore: prefer_const_constructors
                                child: Text('Snap and get you favorite\nfruits & vegetables',
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                              ),
                            ],
                          ),
                          SizedBox(height: y*0.01),
                          Row(
                            children: [
                              Container(
                                height: y*0.04,
                                width: x*0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white
                                ),
                                // ignore: prefer_const_constructors
                                child: Center(child: Text('Capture', style: TextStyle(color: Color(0xff52b53d)))),
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: y*0.16,
                              // ignore: prefer_const_constructors
                              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                              child: Image.asset('assets/f&v2.png',fit: BoxFit.fill),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}