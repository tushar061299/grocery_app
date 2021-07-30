import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/user.dart';

abstract class BaseAuth {
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<bool> createUserWithEmailAndPassword({
    String? name,
    String? phone,
    String? email,
    String? password,
  });

  Future<String> currentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final _firebaseAuth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  late AUser cUser; //currentuser

  Future<AUser> getProfile() async {
    final User? user = _firebaseAuth.currentUser;
    await _store.collection('users').doc(user!.uid).get().then(
          (value) => cUser = AUser(
            uid: user.uid,
            name: value.data()!['name'],
            phone: value.data()!['phone'],
            email: value.data()!['email'],
          ),
        );
    return cUser;
  }

  Future<void> updateProfile(AUser cUser) async {
    final User? user = _firebaseAuth.currentUser;
    var _db = _store.collection('users').doc(user!.uid);
    try {
      await _db.update({
        'name': cUser.name,
        'phone': cUser.phone,
        'email': cUser.email,
      });
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  @override
  Future<bool> createUserWithEmailAndPassword({
    String? name,
    String? phone,
    String? email,
    String? password,
  }) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email as dynamic, password: password as dynamic);
      await addUserDetails(
        name: name,
        email: email,
        phone: phone,
        uid: user.user!.uid,
      );
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  Future<void> addUserDetails({
    String? name,
    String? phone,
    String? email,
    String? uid,
  }) async {
    await _store.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
    });
  }

  @override
  Future<String> currentUser() async {
    final User? user = _firebaseAuth.currentUser;
    return user!.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
