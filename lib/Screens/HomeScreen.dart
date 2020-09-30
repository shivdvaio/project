import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Screens/HomeScreenComponents/body.dart';
import 'package:inventory_management_system/Screens/LoginFeatures/LoginScreen.dart';
import 'package:inventory_management_system/Screens/Products/ProductsList.dart';
import 'package:inventory_management_system/Screens/Products/StockOut/stockoutHistory.dart';
import 'package:inventory_management_system/Screens/Products/products.dart';
import 'package:inventory_management_system/Screens/Stock%20In/StockInHistory.dart';
import 'package:inventory_management_system/Screens/Stock%20In/StockInHistory.dart';
import '';
import 'Stock In/StockInHistory.dart';

class HomeScreen extends StatefulWidget {
  static String Homescreen = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _currentIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: colorforall,
          appBar: buildAppbar(),
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                BodyofHomePage(),
                ProductsList(),
                StockInhistory(),
                StockOutHistory(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: colorforall,
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  title: Text('Home'), icon: Icon(Icons.home,color: Colors.white,)),
              BottomNavyBarItem(
                  title: Text('Products '), icon: Icon(Icons.shopping_bag,color: Colors.white,)),
              BottomNavyBarItem(
                  title: Text('Item In'), icon: Icon(Icons.arrow_downward_outlined,color: Colors.white,)),
              BottomNavyBarItem(
                  title: Text('Item Out'), icon: Icon(Icons.arrow_upward_outlined,color: Colors.white,)),
            ],
          ),
        ));
  }

  AppBar buildAppbar() {
    return AppBar(
      actions: [
        IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            })
      ],
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset('assets/icons/menu.svg'),
      ),
      backgroundColor: colorforall,
    );
  }
}
