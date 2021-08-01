import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:grocery_app/main.dart';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:grocery_app/screens/detailspage.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/dbproducts.dart';

class CameraScreen extends StatefulWidget {
  final List<DBProduct> dblist;
  CameraScreen(this.dblist);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String?> _takePicture() async {
    // Checking whether the controller is initialized
    if (!_controller.value.isInitialized) {
      // ignore: avoid_print
      print("Controller is not initialized");
      return null;
    }

    // Formatting Date and Time
    String dateTime = DateFormat.yMMMd()
        .addPattern('-')
        .add_Hms()
        .format(DateTime.now())
        .toString();

    String formattedDateTime = dateTime.replaceAll(' ', '');
    // ignore: avoid_print
    print("Formatted: $formattedDateTime");

    // Retrieving the path for saving an image
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    //final String visionDir = '${appDocDir.path}/Photos/Vision\ Images';
    // await Directory(visionDir).create(recursive: true);
    final String imagePath; //'$visionDir/image_$formattedDateTime.jpg';

    // Checking whether the picture is being taken
    // to prevent execution of the function again
    // if previous execution has not ended
    if (_controller.value.isTakingPicture) {
      // ignore: avoid_print
      print("Processing is in progress...");
      return null;
    }
    final image;
    try {
      // Captures the image and saves it to the
      // provided path
      image = await _controller.takePicture(); //Add imagePath in take picrure
    } on CameraException catch (e) {
      // ignore: avoid_print
      print("Camera Exception: $e");
      return null;
    }
    imagePath = image.path;
    print("I crush");
    return imagePath;
  }

  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: CustomColors.AppbarColor,
        // ignore: prefer_const_constructors
        title:
            // ignore: prefer_const_constructors
            Text('Scan List ', style: CustomTextStyles.AppbarText),
      ),
      body: _controller.value.isInitialized
          ? Stack(
              children: <Widget>[
                CameraPreview(_controller),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      // ignore: prefer_const_constructors
                      icon: Icon(Icons.camera),
                      // ignore: prefer_const_constructors
                      label: Text("Click"),
                      onPressed: () async {
                        await _takePicture().then((String? path) {
                          if (path != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(path, widget.dblist)),
                            );
                          }
                        });
                      },
                    ),
                  ),
                )
              ],
            )
          : Container(
              color: Colors.black,
              // ignore: prefer_const_constructors
              child: Center(
                // ignore: prefer_const_constructors
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
