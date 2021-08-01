import 'package:flutter/material.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/screens/cartpage.dart';
import 'package:grocery_app/screens/home_page.dart';
//import 'package:grocery_app/screens/search_page.dart';
import 'package:grocery_app/components/pccard.dart';
import 'package:grocery_app/components/pcproductcard.dart';
import 'package:grocery_app/components/pccategorycard.dart';
import 'package:grocery_app/models/pcproducts.dart';
import 'package:grocery_app/services/getpcproducts.dart';

class PersonalCarePage extends StatefulWidget {
  const PersonalCarePage(List<PCProduct> pcitems, {Key? key}) : super(key: key);

  @override
  _PersonalCarePageState createState() => _PersonalCarePageState();
}

class _PersonalCarePageState extends State<PersonalCarePage> {
  PCFetching pcFetching = PCFetching();
  bool isLoaded = true;
  List<PCProduct> pcitems = [];
  List<PCProduct> hcitems = []; //hair care
  List<PCProduct> hmitems = []; //health medicines
  List<PCProduct> fwitems = []; //face wash
  //List<PCProduct> scitems = [];

  @override
  void initState() {
    setState(() {
      isLoaded = false;
    });
    getPCItems().whenComplete(() {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  Future<void> getPCItems() async {
    List<PCProduct> fetchedData2 = await pcFetching.getPC2();
    setState(() {
      pcitems = fetchedData2;
    });
  }

  void categorize() {
    for (int i = 0; i < pcitems.length; i++) {
      if (pcitems[i].category == 'Hair Care') {
        hcitems.add(pcitems[i]);
      }
      if (pcitems[i].category == 'Face Wash') {
        fwitems.add(pcitems[i]);
      }
      if (pcitems[i].category == 'Heath & Medicines') {
        hmitems.add(pcitems[i]);
      }
      // if (dbitems[i].category == 'Toast') {
      //   scitems.add(dbitems[i]);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.black87,
          // ignore: prefer_const_constructors
          title: Text('Personal Care', style: CustomTextStyles.AppbarText),
          actions: [
            // ignore: prefer_const_constructors
            IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
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
            PCCard(pclist: pcitems),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Shop by Category',
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PCCategoryCard(
                    label: 'Hair Care',
                    image: 'assets/Hcpng.png',
                    pclist: hcitems),
                PCCategoryCard(
                    label: 'Health & Medicines',
                    image: 'assets/medicine2.png',
                    pclist: hmitems),
                PCCategoryCard(
                    label: 'Face Wash',
                    image: 'assets/FW.png',
                    pclist: fwitems),
                // PCCategoryCard(
                //     label: 'Toast',
                //     image: 'assets/vegetables.png',
                //     mlist: scitems),
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
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              child: isLoaded
                  ? Column(
                      children: [
                        PCRow(product1: pcitems[0], product2: pcitems[1]),
                        PCRow(product1: pcitems[2], product2: pcitems[3]),
                        PCRow(product1: pcitems[4], product2: pcitems[5]),
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
