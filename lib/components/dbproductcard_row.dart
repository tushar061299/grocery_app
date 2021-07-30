import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/dbproducts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/services/addtocart.dart';

class DBRow extends StatelessWidget {
  const DBRow({
    required this.product1,
    required this.product2,
  });

  final DBProduct product1;
  final DBProduct product2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          DBProductCard(product: product1),
          // ignore: prefer_const_constructors
          SizedBox(width: 15),
          DBProductCard(product: product2),
        ],
      ),
    );
  }
}

class DBProductCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  DBProductCard({
    required this.product,
  });

  final DBProduct product;
  final AddtoCart _addtoCart = AddtoCart();

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: x * 0.51,
        decoration: BoxDecoration(
          color: CustomColors.LightOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: x * 0.18,
              // ignore: prefer_const_constructors
              margin: EdgeInsets.only(bottom: 5, top: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.image!), fit: BoxFit.fitHeight),
              ),
            ),
            Container(
              // ignore: prefer_const_constructors
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    // ignore: prefer_const_constructors
                    child: Text(product.name!,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 4),
                  Row(
                    children: [
                      // ignore: prefer_const_constructors
                      Text('\u20B9 ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      // ignore: prefer_const_constructors
                      Text(product.price!,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  )
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            Spacer(),
            GestureDetector(
              onTap: () {
                _addtoCart.upload(product.image!, product.name!, product.price!,
                    product.pid!, product.quantity!, "M");
                Fluttertoast.showToast(
                  msg: "Product Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                );
              },
              child: Container(
                height: 30,
                // ignore: prefer_const_constructors
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: CustomColors.DarkOrange,
                    borderRadius: BorderRadius.circular(4)),
                // ignore: prefer_const_constructors
                child: Center(
                    child: Text(
                  'ADD TO CART',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
