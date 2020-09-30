import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_management_system/Data/data.dart';
import 'dart:ui';
import 'dart:core';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Screens/HomeScreenComponents/Components/HeaderWithSearchbox.dart';
import 'package:inventory_management_system/Data/data.dart';
import 'package:inventory_management_system/Data/contentmodel.dart';
import 'package:inventory_management_system/Screens/HomeScreenComponents/Components/buildproductListbar.dart';
import 'package:inventory_management_system/Screens/HomeScreenComponents/Components/GridViewComponents/grid.dart';
import 'package:inventory_management_system/Data/ProductsModel.dart';

class BodyofHomePage extends StatefulWidget {
  @override
  _BodyofHomePageState createState() => _BodyofHomePageState();
}

class _BodyofHomePageState extends State<BodyofHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(
      children: [
        Column(
          children: [
            // file in lib/Screens/HomeScreenComponents/Components/buildproductListbar.dart
            headeWithSearchBox(size: size),
            
            ProductsListbar(size: size, content: content),

            GridViewWidget(
              size: size,
            )
          ],
        )
      ],
    );
  }
}



