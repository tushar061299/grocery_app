import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:grocery_app/components/fvsearchcard.dart';


class FVSearchPage extends StatefulWidget {
  final List<FVProduct> fvlist;
  final String title;
  FVSearchPage(this.fvlist,this.title);
  @override
  _FVSearchPageState createState() => _FVSearchPageState();
}

class _FVSearchPageState extends State<FVSearchPage> {
  late int i ;
  List suggestionlist = [];
  void _filter(value){
    setState(() {
      suggestionlist = value.isEmpty ? widget.fvlist
          : widget.fvlist.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.AppbarColor,
        title: Text(widget.title,style: CustomTextStyles.AppbarText),
      ),
      body: getBody(),
    );
  }
  getBody(){
    double x = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50,
            color: CustomColors.AppbarColor,
            child: Padding(
              padding: EdgeInsets.only(left: x*0.03,right: x*0.03,bottom: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: null,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.black)),
                    onChanged: (value){
                      _filter(value);
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          for(int i = 0; i < suggestionlist.length; i++)
            FVSearchCard(product: suggestionlist[i]),
        ],
      ),
    );
  }
}