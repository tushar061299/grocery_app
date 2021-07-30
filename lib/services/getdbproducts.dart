import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/dbproducts.dart';
import 'dart:async';

class DBFetching {
  final _firestore = FirebaseFirestore.instance;

  Future<List<DBProduct>> getDB() async {
    List<DBProduct> items = [];
    var allCollection = await _firestore.collection("DBCatalog").get();
    for (int i = 0; i < allCollection.docs.length; i++) {
      DBProduct mi = DBProduct(
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

  Stream<QuerySnapshot> loadAllDB() {
    return FirebaseFirestore.instance.collection('DBCatalog').snapshots();
  }

  List<DBProduct> getDBFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return DBProduct.fromSnapshot(doc);
    }).toList();
  }

  Future<List<DBProduct>> getDB2() async {
    List<DBProduct> items = [];
    items.clear();
    Stream<QuerySnapshot> productRef = loadAllDB();
    productRef.forEach((element) {
      items.addAll(getDBFromQuery(element));
    });
    return items;
  }
}
