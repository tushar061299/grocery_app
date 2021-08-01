import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/pcsearchcard.dart';
import 'package:grocery_app/models/pcproducts.dart';

class PCCategoryPage extends StatefulWidget {
  final List<PCProduct>? pclist;
  final String title;
  PCCategoryPage(this.pclist, this.title);
  @override
  _PCCategoryPageState createState() => _PCCategoryPageState();
}

class _PCCategoryPageState extends State<PCCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: CustomTextStyles.AppbarText),
        backgroundColor: Colors.black87,
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
            for (int i = 0; i < widget.pclist!.length; i++)
              PCSearchCard(product: widget.pclist![i]),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
