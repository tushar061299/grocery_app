import 'package:cloud_firestore/cloud_firestore.dart';


class FVProduct {
  FVProduct({required this.name, required this.price, required this.category, required this.quantity, required this.pid, required this.image});
  final String image;
  final String pid;
  final String name;
  final String price;
  final String category;
  final String quantity;

  FVProduct.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        pid = snapshot.id,
        name = (snapshot.data() as dynamic)!['name'],
        category = (snapshot.data() as dynamic)!['category'],
        price = (snapshot.data() as dynamic)!['price'],
        image = (snapshot.data() as dynamic)!['image'],
        quantity = (snapshot.data() as dynamic)!['quantity'];
}