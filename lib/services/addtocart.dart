import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.image});
  final String? name;
  final String? price;
  final String? image;
  final String? quantity;
}

class AddtoCart {
  User? user = FirebaseAuth.instance.currentUser;
  upload(String imageurl, String name, String price, String pid,
      String quantity, String category) async {
    await FirebaseFirestore.instance.collection('Cart').doc().set({
      "image": imageurl,
      "name": name,
      "price": price,
      "quantity": quantity,
      "uid": user!.uid,
      "pid": pid,
      "category": category,
    });
  }
}
