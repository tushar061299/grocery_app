import 'package:flutter/material.dart';
import 'package:topica/apptheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:topica/components/cartcard.dart';
import 'package:topica/models/product.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  List<Product> fvMenu = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 50,
      backgroundColor: CustomColors.AppbarColor,
      title: Text('Cart', style: CustomTextStyles.AppbarText),
     ),
      body: getBody(),
    );
  }
  getBody() {
    double x = MediaQuery.of(context).size.width;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Cart").where("uid", isEqualTo: uid).snapshots(),
            builder: (context,snapshot) {
                fvMenu.clear();
              //List<Product> fvMenu = [];
              if (!snapshot.hasData) {
                return Text('No Products Found. Add Products');
              }
              if (snapshot.hasData){
                final smenu = snapshot.data.docs;
                for (var items in smenu){
                  final image  = items.data()["image"];
                  final name = items.data()["name"];
                  final price = items.data()["price"];
                  final quantity = items.data()["quantity"];
                  final did   = items.id;
                  final pro = Product(name: name,price: price,image: image,quantity: quantity,did: did);
                  fvMenu.add(pro);
                }
                if(fvMenu.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: fvMenu.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return CartCard(product: fvMenu[index]);
                        }
                    ),
                  );
                }
              }
              return Expanded(child: Container(height: 300,child: Center(child: Text('No products found, add products.'))));
            }
            ),
          Material(
            child: Container(
              height: 55,width: x,
              color: CustomColors.AppbarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Place Order',style: CustomTextStyles.AppbarText),
                ],
              ),),)
      ],
    );
  }
}