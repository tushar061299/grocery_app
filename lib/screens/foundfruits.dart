import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:topica/components/fvsearchcard.dart';

class FoundProducts extends StatefulWidget {
  final String value;
  final List<FVProduct> fvlist;
  FoundProducts(this.fvlist,this.value);
  @override
  _FoundProductsState createState() => _FoundProductsState();
}

class _FoundProductsState extends State<FoundProducts> {
  List suggestionlist = [];
  List _filter(value){
    return suggestionlist = value.isEmpty ? widget.fvlist
        : widget.fvlist.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
  }
  @override
  Widget build(BuildContext context) {
    _filter(widget.value);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: CustomColors.AppbarColor,
        // ignore: prefer_const_constructors
        title: Text("Fruits Found", style: CustomTextStyles.AppbarText),
      ),
      body: getBody(),
    );
  }
  getBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
            FVSearchCard(product: suggestionlist[0]),
        ],
      ),
    );
  }
}