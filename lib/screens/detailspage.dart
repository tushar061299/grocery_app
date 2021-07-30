import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/dbsearchcard.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:grocery_app/models/dbproducts.dart';

class DetailScreen extends StatefulWidget {
  final List<DBProduct> dblist;
  final String imagePath;
  DetailScreen(this.imagePath, this.dblist);

  @override
  _DetailScreenState createState() => new _DetailScreenState(imagePath);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.path);

  List suggestionlist = [];
  List _filter(value) {
    return suggestionlist = value.isEmpty
        ? widget.dblist
        : widget.dblist
            .where((element) =>
                element.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }

  final String path;
  bool isloaded = true;

  List flist = [];

  Size _imageSize;
  String recognizedText = "Loading ...";

  void _initializeVision() async {
    final File imageFile = File(path);

    if (imageFile != null) {
      await _getImageSize(imageFile);
    }
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    List<String> rtext = [];
    List products = [];

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        rtext.add(line.text);
      }
    }
    for (int i = 0; i < rtext.length; i++) products.addAll(_filter(rtext[i]));

    if (this.mounted) {
      setState(() {
        //isloaded = true;
        flist = products;
        recognizedText = rtext[0];
      });
    }
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    // Fetching image from path
    final Image image = Image.file(imageFile);

    // Retrieving its size
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  @override
  void initState() {
    _initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(flist);
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Products Found"),
        backgroundColor: CustomColors.AppbarColor,
      ),
      body: _imageSize != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  if (flist.length != 0)
                    for (int i = 0; i < flist.length; i++)
                      DBSearchCard(product: flist[i]),
                  if (flist.length == 0)
                    // ignore: sized_box_for_whitespace
                    Container(
                        height: 300,
                        // ignore: prefer_const_constructors
                        child: Center(child: Text("No Products Found"))),
                ],
              ),
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
