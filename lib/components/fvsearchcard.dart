import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:grocery_app/services/addtocart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FVSearchCard extends StatelessWidget {
  FVSearchCard({
    required this.product,
  });

  final FVProduct product;
  final AddtoCart _addtoCart = AddtoCart();

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      // ignore: prefer_const_constructors
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: y * 0.2,
      width: x,
      decoration: BoxDecoration(
        color: CustomColors.LightGreen,
        borderRadius: BorderRadius.circular(12),
      ),
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
                  // ignore: prefer_const_constructors
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
                      // ignore: prefer_const_constructors
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
                    SizedBox(width: x * 0.3),
                    GestureDetector(
                      onTap: () {
                        _addtoCart.upload(
                            product.image!,
                            product.name!,
                            product.price!,
                            product.pid!,
                            product.quantity!,
                            "FV");
                        Fluttertoast.showToast(
                          msg: "Product Added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                        );
                      },
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        // ignore: prefer_const_constructors
                        child: Text('ADD TO CART',
                            style: CustomTextStyles.FVATCText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
