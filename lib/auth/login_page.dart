import 'package:flutter/material.dart';
import 'package:grocery_app/auth/registeration_page.dart';
import 'package:grocery_app/components/authtextfield.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/screens/home_page.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  bool isloaded = true;
  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBody(),
    );
  }

  getBody() {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
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
            Container(
              height: y * 0.5,
              width: x * 0.8,
              // ignore: prefer_const_constructors
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Image.asset('assets/delivery.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Login',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 24,
                    // ignore: prefer_const_constructors
                    color: Color(0xffadad75),
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            AuthTextField(
                tController: idController,
                hintText: 'Email Id',
                validate: (val) => val.isEmpty ? 'Email can\'t be empty' : null,
                t: false),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            AuthTextField(
                tController: passwordController,
                hintText: 'Password',
                validate: (val) => val.length < 6
                    ? 'Enter a valid minimum 6 chars long password'
                    : null,
                t: true),
            // ignore: prefer_const_constructors
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    isloaded = false;
                  });
                  bool at = await signInWithEmailAndPassword(
                      email: idController.text,
                      password: passwordController.text);
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
                child: Center(
                    child: isloaded
                        // ignore: prefer_const_constructors
                        ? Text('Login',
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
                Text('Don\'t have an account? ',
                    // ignore: prefer_const_constructors
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                    },
                    // ignore: prefer_const_constructors
                    child: Text('Register',
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            // ignore: prefer_const_constructors
                            color: Color(0xffadad75),
                            fontWeight: FontWeight.w700,
                            fontSize: 16))),
              ],
            ),
            // ignore: prefer_const_constructors
            Spacer(),
            // ignore: prefer_const_constructors
            SizedBox(height: 1),
          ],
        ),
      ),
    );
  }
}
