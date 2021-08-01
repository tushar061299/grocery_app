import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/cartcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/models/product.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  List<Product> fvMenu = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black87,
        // ignore: prefer_const_constructors
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
            stream: FirebaseFirestore.instance
                .collection("Cart")
                .where("uid", isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshot) {
              fvMenu.clear();
              //List<Product> fvMenu = [];
              if (!snapshot.hasData) {
                // ignore: prefer_const_constructors
                return Text('No Products Found. Add Products');
              }
              if (snapshot.hasData) {
                final smenu = snapshot.data!.docs;
                for (var items in smenu) {
                  final image = (items.data() as dynamic)["image"];
                  final name = (items.data() as dynamic)!["name"];
                  final price = (items.data() as dynamic)!["price"];
                  final quantity = (items.data() as dynamic)!["quantity"];
                  final did = items.id;
                  final pro = Product(
                      name: name,
                      price: price,
                      image: image,
                      quantity: quantity,
                      did: did);
                  fvMenu.add(pro);
                }
                if (fvMenu.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: fvMenu.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return CartCard(product: fvMenu[index]);
                        }),
                  );
                }
              }
              // ignore: sized_box_for_whitespace
              return Expanded(
                child:
                    // ignore: prefer_const_constructors
                    // ignore: sized_box_for_whitespace
                    Container(
                  height: 300,
                  // ignore: prefer_const_constructors
                  child: Center(
                    // ignore: prefer_const_constructors
                    child:
                        // ignore: prefer_const_constructors
                        Text('No products found, add products.'),
                  ),
                ),
              );
            }),
        Material(
          child: Container(
            height: 55,
            width: x,
            color: CustomColors.AppbarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text('Place Order', style: CustomTextStyles.AppbarText),
              ],
            ),
          ),
        )
      ],
    );
  }
}
