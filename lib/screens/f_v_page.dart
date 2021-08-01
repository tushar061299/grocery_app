import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/fvcard.dart';
import 'package:grocery_app/components/fvcategorycard.dart';
import 'package:grocery_app/components/fvproductcard_row.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:grocery_app/screens/cartpage.dart';
import 'package:grocery_app/screens/fvsearchpage.dart';

class FVPage extends StatefulWidget {
  final List<FVProduct> fvlist;
  FVPage(this.fvlist);
  @override
  _FVPageState createState() => _FVPageState();
}

class _FVPageState extends State<FVPage> {
  bool isLoaded = true;
  List<FVProduct> ftsitems = [];
  List<FVProduct> vtsitems = [];

  @override
  void initState() {
    categorize();
    super.initState();
  }

  categorize() {
    // ignore: avoid_print
    print(widget.fvlist.length);
    for (int i = 0; i < widget.fvlist.length; i++) {
      if (widget.fvlist[i].category == 'Fruits') {
        ftsitems.add(widget.fvlist[i]);
      }
      if (widget.fvlist[i].category == 'Vegetables') {
        vtsitems.add(widget.fvlist[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: CustomColors.AppbarColor,
        // ignore: prefer_const_constructors
        title: Text('Fruits & Vegetables', style: CustomTextStyles.AppbarText),
        actions: [
          // ignore: prefer_const_constructors
          IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FVSearchPage(
                            widget.fvlist, "Fruits & Vegetables")));
              }),
          // ignore: prefer_const_constructors
          IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              }),
        ],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Container(
        // ignore: prefer_const_constructors
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            FVCard(fvlist: ftsitems),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text('Shop by Category',
                    style:
                        // ignore: prefer_const_constructors
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FVCategoryCard(
                    label: 'Fruits',
                    image: 'assets/fruits.png',
                    fvlist: ftsitems),
                FVCategoryCard(
                    label: 'Vegetables',
                    image: 'assets/vegetables.png',
                    fvlist: vtsitems)
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text('Popular',
                    style:
                        // ignore: prefer_const_constructors
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
            FVRow(product1: widget.fvlist[0], product2: widget.fvlist[1]),
            FVRow(product1: widget.fvlist[2], product2: widget.fvlist[3]),
            FVRow(product1: widget.fvlist[4], product2: widget.fvlist[5]),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
