import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/dbcard.dart';
import 'package:grocery_app/components/dbproductcard_row.dart';
import 'package:grocery_app/screens/search_page.dart';
import 'package:grocery_app/services/getdbproducts.dart';
import 'package:grocery_app/components/dbcategorycard.dart';
import 'package:grocery_app/models/dbproducts.dart';
import 'package:grocery_app/screens/cartpage.dart';

class DBPage extends StatefulWidget {
  DBPage({Key? key}) : super(key: key);

  @override
  _DBPageState createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {
  DBFetching dbFetching = DBFetching();
  bool isLoaded = true;
  List<DBProduct> dbitems = [];
  List<DBProduct> mditems = [];
  List<DBProduct> faitems = [];
  List<DBProduct> pitems = [];
  List<DBProduct> scitems = [];

  @override
  void initState() {
    setState(() {
      isLoaded = false;
    });
    getDBItems().whenComplete(() {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  Future<void> getDBItems() async {
    List<DBProduct> fetchedData = await dbFetching.getDB2();
    setState(() {
      dbitems = fetchedData;
    });
  }

  void categorize() {
    for (int i = 0; i < dbitems.length; i++) {
      if (dbitems[i].category == 'First Aid') {
        faitems.add(dbitems[i]);
      }
      if (dbitems[i].category == 'Medicines') {
        mditems.add(dbitems[i]);
      }
      if (dbitems[i].category == 'Protein') {
        pitems.add(dbitems[i]);
      }
      if (dbitems[i].category == 'Skin Care') {
        scitems.add(dbitems[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: CustomColors.AppbarColor,
          title: Text('Medicines', style: CustomTextStyles.AppbarText),
          actions: [
            // ignore: prefer_const_constructors
            IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchPage(dbitems, 'Medicine Search')));
                }),
            // ignore: prefer_const_constructors
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                }),
          ],
        ),
        body: getBody());
  }

  getBody() {
    categorize();
    return SingleChildScrollView(
      child: Container(
        // ignore: prefer_const_constructors
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            DBCard(dblist: dbitems),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Shop by Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DBCategoryCard(
                    label: 'Medicines',
                    image: 'assets/medicine3.png',
                    mlist: mditems),
                DBCategoryCard(
                    label: 'First Aid',
                    image: 'assets/firstaid.png',
                    mlist: faitems),
                DBCategoryCard(
                    label: 'Protein',
                    image: 'assets/protein.png',
                    mlist: pitems),
                DBCategoryCard(
                    label: 'Skin Care',
                    image: 'assets/skincare.png',
                    mlist: scitems),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Popular',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              child: isLoaded
                  ? Column(
                      children: [
                        DBRow(product1: dbitems[0], product2: dbitems[1]),
                        DBRow(product1: dbitems[2], product2: dbitems[3]),
                        DBRow(product1: dbitems[4], product2: dbitems[5]),
                      ],
                    )
                  // ignore: prefer_const_constructors
                  : Center(child: CircularProgressIndicator()),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
