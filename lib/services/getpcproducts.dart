import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/pcproducts.dart';
import 'dart:async';

class PCFetching {
  final _firestore = FirebaseFirestore.instance;

  Future<List<PCProduct>> getPC() async {
    List<PCProduct> items = [];
    var allCollection = await _firestore.collection("PCCatalog").get();
    for (int i = 0; i < allCollection.docs.length; i++) {
      PCProduct mi = PCProduct(
        image: allCollection.docs[i].data()['image'],
        name: allCollection.docs[i].data()['name'],
        price: allCollection.docs[i].data()['price'],
        type: allCollection.docs[i].data()['type'],
        quantity: allCollection.docs[i].data()['quantity'],
        category: allCollection.docs[i].data()['category'],
        pid: allCollection.docs[i].id,
      );
      items.add(mi);
    }
    return items;
  }

  Stream<QuerySnapshot> loadAllPC() {
    return FirebaseFirestore.instance.collection('PCCatalog').snapshots();
  }

  List<PCProduct> getPCFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return PCProduct.fromSnapshot(doc);
    }).toList();
  }

  Future<List<PCProduct>> getPC2() async {
    List<PCProduct> items = [];
    items.clear();
    Stream<QuerySnapshot> productRef = loadAllPC();
    productRef.forEach((element) {
      items.addAll(getPCFromQuery(element));
    });
    return items;
  }
}
