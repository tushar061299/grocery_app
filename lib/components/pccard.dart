import 'package:flutter/material.dart';
import 'package:grocery_app/models/pcproducts.dart';
// import 'package:grocery_app/screens/camerapage.dart';

class PCCard extends StatelessWidget {
  const PCCard({
    required this.pclist,
  });
  final List<PCProduct> pclist;
  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => CameraScreen(dblist)));
      },
      child: Row(
        children: [
          Expanded(
            child: Material(
              // ignore: prefer_const_constructors
              color: Color(0xfff88a77),
              elevation: 1,
              borderRadius: BorderRadius.circular(8),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: y * 0.208,
                child: Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.only(top: 25, left: 15, bottom: 5),
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
                                child: Text(
                                  'Now get your Groceries\ndelivered by a snap',
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: y * 0.01),
                          Row(
                            children: [
                              Container(
                                height: y * 0.04,
                                width: x * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white),
                                // ignore: prefer_const_constructors
                                child: Center(
                                    // ignore: prefer_const_constructors
                                    child: Text('Capture',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            // ignore: prefer_const_constructors
                                            color: Color(0xfff88a77)))),
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: y * 0.16,
                              // ignore: prefer_const_constructors
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              child: Image.asset('assets/PcMain png.png',
                                  fit: BoxFit.fill),
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
