import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/dbsearchcard.dart';
import 'package:grocery_app/models/dbproducts.dart';

class SearchPage extends StatefulWidget {
  final List<DBProduct> dblist;
  final String title;
  SearchPage(this.dblist, this.title);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late int i;
  List? suggestionlist = [];
  void _filter(value) {
    setState(() {
      suggestionlist = value.isEmpty
          ? widget.dblist
          : widget.dblist
              .where((element) =>
                  element.name!.toLowerCase().contains(value.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.AppbarColor,
        title: Text(widget.title, style: CustomTextStyles.AppbarText),
      ),
      body: getBody(),
    );
  }

  getBody() {
    double x = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50,
            color: CustomColors.AppbarColor,
            child: Padding(
              padding:
                  EdgeInsets.only(left: x * 0.03, right: x * 0.03, bottom: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: null,
                        hintText: "Search",
                        // ignore: prefer_const_constructors
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                        ),
                        // ignore: prefer_const_constructors
                        prefixIcon: Icon(Icons.search, color: Colors.black)),
                    onChanged: (value) {
                      _filter(value);
                    },
                  ),
                ),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(height: 6),
          for (int i = 0; i < suggestionlist!.length; i++)
            DBSearchCard(product: suggestionlist![i]),
        ],
      ),
    );
  }
}
