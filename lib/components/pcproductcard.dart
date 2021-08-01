import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/pcproducts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/services/addtocart.dart';

class PCRow extends StatelessWidget {
  const PCRow({
    required this.product1,
    required this.product2,
  });

  final PCProduct product1;
  final PCProduct product2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          PCProductCard(product: product1),
          // ignore: prefer_const_constructors
          SizedBox(width: 15),
          PCProductCard(product: product2),
        ],
      ),
    );
  }
}

class PCProductCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  PCProductCard({
    required this.product,
  });

  final PCProduct product;
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
                    image: NetworkImage(product.image ?? 'assets/HCpng.png'),
                    fit: BoxFit.fitHeight),
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
                    child: Text(product.name ?? "Hair Care",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 4),
                  Row(
                    children: [
                      // ignore: prefer_const_constructors
                      Text('\u20B9 ',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      // ignore: prefer_const_constructors
                      Text(product.price!,
                          // ignore: prefer_const_constructors
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
                    // ignore: prefer_const_constructors
                    child: Text(
                  'ADD TO CART',
                  // ignore: prefer_const_constructors
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
