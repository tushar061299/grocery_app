import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/dbsearchcard.dart';
import 'package:grocery_app/models/dbproducts.dart';

class DBCategoryPage extends StatefulWidget {
  final List<DBProduct> dblist;
  final String title;
  DBCategoryPage(this.dblist, this.title);
  @override
  _DBCategoryPageState createState() => _DBCategoryPageState();
}

class _DBCategoryPageState extends State<DBCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: CustomTextStyles.AppbarText),
        backgroundColor: CustomColors.AppbarColor,
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            for (int i = 0; i < widget.dblist.length; i++)
              DBSearchCard(product: widget.dblist[i]),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
