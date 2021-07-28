import 'package:flutter/material.dart';
import 'package:grocery_app/auth/login_page.dart';
import 'package:grocery_app/screens/home_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/components/authtextfield.dart';

// ignore: use_key_in_widget_constructors
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  final key = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloaded = true;

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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // ignore: prefer_const_constructors
      body: getBody(),
    );
  }

  getBody() {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      // ignore: avoid_unnecessary_containers
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          // ignore: unnecessary_new
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
            // ignore: prefer_const_constructors
            image: AssetImage("assets/first.jpg"),
          ),
          color: Colors.white24,
        ),
        child: Column(
          children: [
            SizedBox(height: y * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Register',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontSize: 24,
                      // ignore: prefer_const_constructors
                      color: Color(0xffadad75),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            AuthTextField(
                hintText: 'Name',
                tController: nameController,
                validate: (val) => val.isEmpty ? 'Name cannot be empty' : null,
                t: false),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            AuthTextField(
                hintText: 'Mobile No',
                tController: mobileController,
                validate: (val) =>
                    val.isEmpty ? 'Mobile no cannot be empty' : null,
                t: false),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            AuthTextField(
                hintText: 'Email Id',
                tController: emailController,
                validate: (val) => val.isEmpty ? 'Email cannot be empty' : null,
                t: false),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            AuthTextField(
                hintText: 'Password',
                tController: passwordController,
                validate: (val) => val.length < 6
                    ? 'Enter a password atleast 6 chars long'
                    : null,
                t: true),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isloaded = false;
                  });
                  bool at = await createUserWithEmailAndPassword(
                    name: nameController.text,
                    phone: mobileController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  setState(() {
                    isloaded = true;
                  });
                  if (at) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                }
              },
              child: Container(
                height: x * 0.108,
                width: x * 0.7,
                decoration: BoxDecoration(
                  // ignore: prefer_const_constructors
                  color: Color(0xffadad75),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // ignore: prefer_const_constructors
                child: Center(
                    child: isloaded
                        // ignore: prefer_const_constructors
                        ? Text('Register',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18))
                        // ignore: prefer_const_constructors
                        : CircularProgressIndicator(strokeWidth: 3)),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Text('Already have an account? ',
                    // ignore: prefer_const_constructors
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    // ignore: prefer_const_constructors
                    child: Text('Login',
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            // ignore: prefer_const_constructors
                            color: Color(0xffadad75),
                            fontWeight: FontWeight.w700,
                            fontSize: 16))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
