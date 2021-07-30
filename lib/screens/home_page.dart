import 'package:flutter/material.dart';
import 'package:grocery_app/components/home_card.dart';
import 'package:grocery_app/apptheme.dart';
import 'package:grocery_app/components/home_slider.dart';
import 'package:grocery_app/screens/f_v_page.dart';
import 'package:grocery_app/screens/dairy_bakery_page.dart';
//import 'package:grocery_app/screens/personal_care_page.dart';
//import 'package:grocery_app/services.dart/getdbproducts.dart';
//import 'package:grocery_app/models/dbproducts.dart';
import 'package:grocery_app/services.dart/getfvproducts.dart';
import 'package:grocery_app/models/fvproducts.dart';
import 'package:grocery_app/services.dart/getuser.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/components/appdrawer.dart';
import 'package:grocery_app/screens/cartpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'G';
  // ignore: prefer_final_fields
  GlobalKey<ScaffoldState> _sckey = GlobalKey<ScaffoldState>();
  // ignore: prefer_final_fields
  UserFetching _userFetching = UserFetching();
  //MedicineFetching medFetching = MedicineFetching();
  // ignore: prefer_final_fields
  FVFetching _fvFetching = FVFetching();
  //List<MProduct> mitems = [];
  List<FVProduct> fvtems = [];
  bool isLoaded = true;
  late AUser cuser;
  List imageArray = [
    'assets/offers.jpg',
    'assets/offers1.jpg',
    'assets/offers2.jpg',
    'assets/slider4.jpeg',
    'assets/slider6.jpeg',
    'assets/slider3.jpg'
  ];
  Future<void> getUser() async {
    AUser _cuser = await _userFetching.getUser();
    setState(() {
      userName = _cuser.name;
    });
  }

  Future<void> getMedicineItems() async {
    // List fetchedData = await medFetching.getMedicines2();
    List<FVProduct> fetchedData1 = await _fvFetching.getFV();
    setState(() {
      //mitems = fetchedData;
      fvtems = fetchedData1;
    });
  }

  @override
  void initState() {
    getUser();
    setState(() {
      isLoaded = false;
    });
    getMedicineItems().whenComplete(() {
      setState(() {
        isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sckey,
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black87,
        leading: IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(Icons.menu),
          onPressed: () => _sckey.currentState!.isDrawerOpen
              ? Navigator.of(context).pop(context)
              : _sckey.currentState!.openDrawer(),
        ),
        title: Text("Hello " + userName, style: CustomTextStyles.AppbarText),
        actions: [
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: prefer_const_constructors
          SizedBox(height: 10),
          HomeSlider(imageArray: imageArray),
          // ignore: prefer_const_constructors
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Text('Shop by Category',
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ],
          ),
          // ignore: prefer_const_constructors
          SizedBox(height: 10),
          Row(
            children: [
              // ignore: prefer_const_constructors
              Spacer(),
              HomeCard(
                title: 'Food',
                image: 'assets/food.png',
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DBPage()));
                },
              ),
              // SizedBox(width: 15),
              // HomeCard(
              //   title: 'Medicine',
              //   image: 'assets/medicine.png',
              //   onpress: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => MedicinePage()));
              //   },
              // ),
              // Spacer(),
            ],
          ),
          // ignore: prefer_const_constructors
          SizedBox(height: 15),
          Row(
            children: [
              Spacer(),
              HomeCard(
                title: 'Fruits & Vegetables',
                image: 'assets/f&v.png',
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FVPage(fvtems)));
                },
              ),
              // ignore: prefer_const_constructors
              Spacer(),
            ],
          ),
          HomeSlider(imageArray: imageArray),
        ],
      ),
    );
  }
}
