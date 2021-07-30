import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFetching {
  late AUser cuser; //currentuser

  Future<AUser> getUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      cuser = AUser(
          uid: user.uid,
          name: (value.data() as dynamic)!['name'],
          email: (value.data() as dynamic)!['email'],
          phone: (value.data() as dynamic)!['phone']);
    });
    return cuser;
  }
}
