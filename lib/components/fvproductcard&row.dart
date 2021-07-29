import 'package:flutter/material.dart';
import 'package:topica/models/fvproducts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:topica/services/addtocart.dart';


class FVRow extends StatelessWidget {
  const FVRow({
    @required this.product1,
    @required this.product2,
  });

  final FVProduct product1;
  final FVProduct product2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          FVProductCard(product: product1),
          SizedBox(width: 12),
          FVProductCard(product: product2),
        ],
      ),
    );
  }
}


class FVProductCard extends StatelessWidget {
   FVProductCard({
    @required this.product,
  });

  final FVProduct product;
  final AddtoCart _addtoCart = AddtoCart();


  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: x*0.47,
        decoration: BoxDecoration(
          color: Color(0xffc3ffba),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: x*0.2,
              margin: EdgeInsets.only(bottom: 10,top: 8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(product.image), fit: BoxFit.fitHeight),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('\u20B9 ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text(product.price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                _addtoCart.upload(product.image, product.name, product.price, product.pid, product.quantity,"FV");
                Fluttertoast.showToast(
                  msg: "Product Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                );
              },
              child: Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Color(0xff52b53d),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Center(child: Text('ADD TO CART',style: TextStyle(color: Colors.white),)),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),);
  }
}