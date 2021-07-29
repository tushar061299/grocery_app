import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/fvsearchcard.dart';
import 'package:grocery_app/models/fvproducts.dart';

class FVCategoryPage extends StatefulWidget {
  final List<FVProduct> fvlist;
  final String title;
  FVCategoryPage(this.fvlist,this.title);
  @override
  _FVCategoryPageState createState() => _FVCategoryPageState();
}

class _FVCategoryPageState extends State<FVCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: CustomTextStyles.AppbarText),
        backgroundColor: CustomColors.AppbarColor,
      ),
      body: getBody(),
    );
  }
  getBody() {
    return SingleChildScrollView(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            SizedBox(height: 6),
            for(int i = 0; i< widget.fvlist.length; i++)
              FVSearchCard(product: widget.fvlist[i]),
          ],
        ),
      ),
    );
  }
}