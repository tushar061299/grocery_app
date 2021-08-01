import 'package:cloud_firestore/cloud_firestore.dart';

class PCProduct {
  PCProduct(
      {required this.name,
      required this.price,
      required this.type,
      required this.category,
      required this.quantity,
      required this.pid,
      required this.image});
  final String? image;
  final String? pid;
  final String? name;
  final String? price;
  final String? category;
  final String? quantity;
  final String? type;

  PCProduct.fromSnapshot(DocumentSnapshot snapshot)
      : pid = snapshot.id,
        name = (snapshot.data() as dynamic)!["name"],
        category = (snapshot.data() as dynamic)!['category'],
        price = (snapshot.data() as dynamic)!['price'],
        image = (snapshot.data() as dynamic)!['image'],
        type = (snapshot.data() as dynamic)!['type'],
        quantity = (snapshot.data() as dynamic)!['quantity'];
}
