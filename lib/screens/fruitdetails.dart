import 'package:flutter/material.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:grocery_app/screens/foundfruits.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:grocery_app/apptheme.dart';

class DetectMain extends StatefulWidget {
  final List<FVProduct> fvlist;
  DetectMain(this.fvlist);
  @override
  _DetectMainState createState() => new _DetectMainState();
}

class _DetectMainState extends State<DetectMain> {
  late File _image;
  late double _imageWidth;
  late double _imageHeight;
  // ignore: prefer_typing_uninitialized_variables
  var _recognitions;

  loadModel() async {
    Tflite.close();

    // String res;
    // res = (await Tflite.loadModel(
    //   // model: "assets/fruits.tflite",
    //   // labels: "assets/dict.txt",
    // ))!;
    // // ignore: avoid_print
    // print(res);
  }

  press() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FoundProducts(
                widget.fvlist, _recognitions[0]['label'].toString())));
  }

  // run prediction using TFLite on given image
  Future predict(XFile image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path, // required
      threshold: 0.4, // defaults to 0.1
      // defaults to true
    );

    // ignore: avoid_print
    print(recognitions);

    setState(() {
      _recognitions = recognitions;
    });
  }

  sendImage(XFile image) async {
    // ignore: unnecessary_null_comparison
    if (image == null) return;
    await predict(image);

    // ignore: prefer_const_constructors
    FileImage(image as File)
        // ignore: prefer_const_constructors
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image as File;
          });
        })));
  }

  // select image from gallery
  selectFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  // select image from camera
  selectFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {});
    });
  }

  Widget printValue(rcg) {
    if (rcg == null) {
      // ignore: prefer_const_constructors
      return Text('',
          // ignore: prefer_const_constructors
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      // ignore: prefer_const_constructors
      return Center(
        // ignore: prefer_const_constructors
        child: Text("Could not recognize",
            // ignore: prefer_const_constructors
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "Prediction: " + _recognitions[0]['label'].toString().toUpperCase(),
          // ignore: prefer_const_constructors
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // gets called every time the widget need to re-render or build
  @override
  Widget build(BuildContext context) {
    // get the width and height of current screen the app is running on
    Size size = MediaQuery.of(context).size;

    // initialize two variables that will represent final width and height of the segmentation
    // and image preview on screen
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    // ignore: unnecessary_null_comparison
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      // ratio width and ratio height will given ratio to
      // scale up or down the preview image
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW * .85;
      finalH = _imageHeight * ratioH * .50;
    }

//    List<Widget> stackChildren = [];

    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text("Find Fruits", style: CustomTextStyles.AppbarText),
          backgroundColor: CustomColors.AppbarColor,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: printValue(_recognitions),
            ),
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              // ignore: prefer_const_constructors
              // ignore: unnecessary_null_comparison
              child: _image == null
                  ?
                  // ignore: prefer_const_constructors
                  Center(
                      child:
                          // ignore: prefer_const_constructors
                          Text("Select image from camera or gallery"),
                    )
                  : Center(
                      child: Image.file(_image,
                          fit: BoxFit.fill, width: finalW, height: finalH)),
            ),
            // ignore: prefer_const_constructors
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(top: 15),
              // ignore: unnecessary_null_comparison
              child: _image != null ? FindButton(onpress: press) : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.redAccent,
                    // ignore: deprecated_member_use
                    child: FlatButton.icon(
                      onPressed: selectFromCamera,
                      // ignore: prefer_const_constructors
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      color: Colors.deepPurple,
                      // ignore: prefer_const_constructors
                      label: Text(
                        // ignore: prefer_const_constructors
                        "Camera",
                        // ignore: prefer_const_constructors
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  color: Colors.tealAccent,
                  // ignore: deprecated_member_use
                  child: FlatButton.icon(
                    onPressed: selectFromGallery,
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.file_upload,
                      color: Colors.white,
                      size: 30,
                    ),
                    color: Colors.blueAccent,
                    // ignore: prefer_const_constructors
                    label: Text(
                      // ignore: prefer_const_constructors
                      "Gallery",
                      // ignore: prefer_const_constructors
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                ),
              ],
            ),
          ],
        ));
  }
}

class FindButton extends StatelessWidget {
  final Function onpress;
  // ignore: prefer_const_constructors_in_immutables
  FindButton({required this.onpress});
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 50,
      width: 150,
      // ignore: deprecated_member_use
      child: FlatButton.icon(
        onPressed: onpress(),
        // ignore: prefer_const_constructors
        icon: Icon(Icons.search, color: Colors.white, size: 30),
        color: Colors.green,
        // ignore: prefer_const_constructors
        label: Text(
          // ignore: prefer_const_constructors
          "Find Products", style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
