import 'package:flutter/material.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:topica/screens/foundfruits.dart';


class DetectMain extends StatefulWidget {
  final List<FVProduct> fvlist;
  DetectMain(this.fvlist);
  @override
  _DetectMainState createState() => new _DetectMainState();
}

class _DetectMainState extends State<DetectMain> {
  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;

  loadModel() async {
    Tflite.close();

      String res;
      res = (await Tflite.loadModel(
        model: "assets/fruits.tflite",
        labels: "assets/dict.txt",
      ))!;
      print(res);

  }

  press() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FoundProducts(widget.fvlist,_recognitions[0]['label'].toString())));
  }


  // run prediction using TFLite on given image
  Future predict(File image) async {

    var recognitions = await Tflite.runModelOnImage(
        path: image.path,   // required
        threshold: 0.4,   // defaults to 0.1
      // defaults to true
    );

    print(recognitions);

    setState(() {
      _recognitions = recognitions;
    });

  }

  sendImage(File image) async {
    if(image == null) return;
    await predict(image);

    FileImage(image).resolve(ImageConfiguration()).addListener((ImageStreamListener((ImageInfo info, bool _){
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
        _image = image;
      });
    })));
  }

  // select image from gallery
  selectFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image == null) return;
    setState(() {

    });
    sendImage(image);
  }

  // select image from camera
  selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image == null) return;
    setState(() {

    });
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
      return Text('', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    }else if(rcg.isEmpty){
      return Center(
        child: Text("Could not recognize", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0,0,0,0),
      child: Center(
        child: Text(
          "Prediction: "+_recognitions[0]['label'].toString().toUpperCase(),
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
    if(_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    }else {

      // ratio width and ratio height will given ratio to
      // scale up or down the preview image
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW*.85;
      finalH = _imageHeight * ratioH*.50;
    }

//    List<Widget> stackChildren = [];


    return Scaffold(
        appBar: AppBar(
          title: Text("Find Fruits", style: CustomTextStyles.AppbarText),
          backgroundColor: CustomColors.AppbarColor,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0,30,0,30),
              child: printValue(_recognitions),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0,0,0,10),
              child: _image == null ? Center(child: Text("Select image from camera or gallery"),): Center(child: Image.file(_image, fit: BoxFit.fill, width: finalW, height: finalH)),
            ),
            Padding(padding: EdgeInsets.only(top: 15),
              child: _image != null ?  FindButton(onpress: press): null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.redAccent,
                    child: FlatButton.icon(
                      onPressed: selectFromCamera,
                      icon: Icon(Icons.camera_alt, color: Colors.white, size: 30,),
                      color: Colors.deepPurple,
                      label: Text(
                        "Camera",style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  color: Colors.tealAccent,
                  child: FlatButton.icon(
                    onPressed: selectFromGallery,
                    icon: Icon(Icons.file_upload, color: Colors.white, size: 30,),
                    color: Colors.blueAccent,
                    label: Text(
                      "Gallery",style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                ),
              ],
            ),
          ],
        )
    );
  }
}

class FindButton extends StatelessWidget {
  final Function onpress;
  FindButton({@required this.onpress});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      child: FlatButton.icon(
        onPressed: onpress,
        icon: Icon(Icons.search, color: Colors.white, size: 30),
        color: Colors.green,
        label: Text(
          "Find Products",style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}