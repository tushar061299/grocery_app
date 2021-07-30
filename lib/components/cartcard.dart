import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartCard extends StatelessWidget {
  CartCard({
    required this.product,
  });

  final Product product;
  deleteDoc(String did) {
    FirebaseFirestore.instance.collection("Cart").doc(did).delete();
  }

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      //padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      height: y * 0.2,
      width: x,
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 5,
        child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            children: [
              Container(
                width: x * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product.image!), fit: BoxFit.contain),
                ),
              ),
              // ignore: prefer_const_constructors
              Spacer(),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: prefer_const_constructors
                    SizedBox(height: 6),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: x * 0.56,
                      child: Text(product.name!,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 14.5, fontWeight: FontWeight.w600)),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(height: 6),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          // ignore: prefer_const_constructors
                          Text('\u20B9 ',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Text(product.price! + ' (' + product.quantity! + ')',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontSize: 14.5, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: x * 0.39),
                        GestureDetector(
                          onTap: () {
                            deleteDoc(product.did!);
                          },
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            // ignore: prefer_const_constructors
                            child:
                                Text('Remove', style: CustomTextStyles.CRText),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
