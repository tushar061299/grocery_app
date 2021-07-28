import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/auth/login_page.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];

///Global list to store list of cameras available on device

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    /// Retrieve the device cameras
  } on CameraException catch (e) {
    // ignore: avoid_print
    print(e);
  }
  await Firebase.initializeApp();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// To make sure app always remain in portrait
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
