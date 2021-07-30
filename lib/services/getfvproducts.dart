import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'dart:async';

class FVFetching {
  Stream<QuerySnapshot> loadAllFV() {
    return FirebaseFirestore.instance.collection('FVCatalog').snapshots();
  }

  List<FVProduct> getFVFromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return FVProduct.fromSnapshot(doc);
    }).toList();
  }

  Future<List<FVProduct>> getFV() async {
    List<FVProduct> items = [];
    items.clear();
    Stream<QuerySnapshot> productRef = loadAllFV();
    productRef.forEach((element) {
      items.addAll(getFVFromQuery(element));
    });
    return items;
  }
}
