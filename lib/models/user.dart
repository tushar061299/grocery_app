// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class AUser {
  AUser(
      {required this.uid,
      required this.email,
      required this.name,
      required this.phone});
  final String uid;
  final String name;
  final String email;
  final String phone;

  AUser.fromSnapshot(DocumentSnapshot snapshot)
      // ignore: unnecessary_null_comparison
      : assert(snapshot != null),
        uid = snapshot.id,
        name = (snapshot.data() as dynamic)!["name"],
        email = (snapshot.data() as dynamic)!['email'],
        phone = (snapshot.data() as dynamic)!['phone'];
}
