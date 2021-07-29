  
import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/fvcard.dart';
import 'package:grocery_app/components/fvcategorycard.dart';
import 'package:grocery_app/components/fvproductcard&row.dart';
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
    for (int i = 0; i < widget.fvlist.length; i++) {
      if (widget.fvlist[i].category == 'Fruits')
        ftsitems.add(widget.fvlist[i]);
      if (widget.fvlist[i].category == 'Vegetables')
        vtsitems.add(widget.fvlist[i]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: CustomColors.AppbarColor,
        title: Text('Fruits & Vegetables', style: CustomTextStyles.AppbarText),
        actions: [
          IconButton(icon: Icon(Icons.search,color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FVSearchPage(widget.fvlist, "Fruits & Vegetables")));
          }),
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
          }),
        ],
      ),
      body: getBody (),
    );
  }
  getBody () {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 12),
            FVCard(fvlist: ftsitems),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Shop by Category',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FVCategoryCard(label:'Fruits',image: 'assets/fruits.png',fvlist: ftsitems),
                FVCategoryCard(label: 'Vegetables', image: 'assets/vegetables.png',fvlist: vtsitems)
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Text('Popular',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
              ],
            ),
            FVRow(product1: widget.fvlist[0],product2: widget.fvlist[1]),
            FVRow(product1: widget.fvlist[2],product2: widget.fvlist[3]),
            FVRow(product1: widget.fvlist[4],product2: widget.fvlist[5]),
            SizedBox(height: 12),
            ],
        ),
      ),
    );
  }
}
