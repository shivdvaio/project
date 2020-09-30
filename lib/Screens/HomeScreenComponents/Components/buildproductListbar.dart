import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_management_system/Data/data.dart';
import 'dart:ui';
import 'dart:core';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Screens/HomeScreenComponents/Components/HeaderWithSearchbox.dart';
import 'package:inventory_management_system/Data/data.dart';
import 'package:inventory_management_system/Data/contentmodel.dart';


class ProductsListbar extends StatelessWidget {
  const ProductsListbar({
    Key key,
    @required this.size,
    @required this.content,
  }) : super(key: key);

  final Size size;
  final List<Content> content;

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: EdgeInsets.all(size.width * 0.02),
      child: Container(
        
        height: size.height * 0.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: content.length,
            itemBuilder: (BuildContext context, int index) {
              Content contentobj = content[index];
              return Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: gradient,
                        borderRadius:
                            BorderRadius.circular(size.width * 0.03),
                        color: containerColors,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(contentobj.assetName))),
                    height: size.height * 0.3,
                    width: size.width * 0.4),
              );
            }),
      ),
    );
  }
}

// class CustomTitle extends StatelessWidget {
//   CustomTitle({this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(kDefaultPadding / 5),
//             child: Text("$title",
//                 style: Theme.of(context).textTheme.headline6.copyWith(
//                     color: Colors.black, fontWeight: FontWeight.bold)),
//           ),
//           Container(height: 7, color: Colors.transparent),
//         ],
//       ),
//     );
//   }
// }
