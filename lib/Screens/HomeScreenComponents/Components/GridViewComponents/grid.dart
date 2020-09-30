import 'package:flutter/material.dart';
import 'package:inventory_management_system/Data/constant.dart';

import 'package:inventory_management_system/Screens/Products/ProductsList.dart';
import 'package:inventory_management_system/Screens/Products/StockOut/addinstockOut.dart';
import 'package:inventory_management_system/Screens/Products/StockOut/stockoutHistory.dart';
import 'package:inventory_management_system/Screens/Products/add%20products.dart';
import 'package:inventory_management_system/Screens/Products/products.dart';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:inventory_management_system/Screens/Stock%20In/StockInHistory.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridViewWidget extends StatelessWidget {
  GridViewWidget({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 17,
        mainAxisSpacing: 15.0,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          Container(
            child: gridViewColumn(
              svgicondir: 'assets/icons/icons8-hotel-check-in.svg',
              onPressed: () {
                snackbarOFitems(
                    context: context,
                    size: size,
                    textchoice1: "Choose From Products",
                    textChoice2: "See Stock In History",
                    functionforProducts: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ListViewOfProducts();
                      }));
                    },
                    functionforStockHistory: () {
                      Get.to(StockInhistory());
                    });
              },
              text: "Stock In",
            ),
            decoration: BoxDecoration(
              gradient: gradient2,
              boxShadow: [kDefaultShadow],
              color: containerColors,
              borderRadius: BorderRadius.circular(size.width * 0.03),
            ),
          ),
          Container(
            child: gridViewColumn(
              svgicondir: 'assets/icons/stockin.svg',
              onPressed: () {
                snackbarOFitems(
                    context: context,
                    size: size,
                    textchoice1: "Choose From Products",
                    textChoice2: "See Stock Out History",
                    functionforProducts: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AddinStockOut();
                      }));
                    },
                    functionforStockHistory: () {
                      Get.to(StockOutHistory());
                    });
              },
              text: "Stock Out",
            ),
            decoration: BoxDecoration(
                gradient: gradient2,
                boxShadow: [kDefaultShadow],
                borderRadius: BorderRadius.circular(size.width * 0.03),
                color: containerColors),
          ),
          Container(
            child: gridViewColumn(
              svgicondir: 'assets/icons/products1.svg',
              onPressed: () {
                Get.to(ProductsList());
              },
              text: "Products",
            ),
            decoration: BoxDecoration(
                gradient: gradient2,
                borderRadius: BorderRadius.circular(size.width * 0.03),
                color: containerColors),
          ),
          Container(
            child: gridViewColumn(
              svgicondir: 'assets/icons/icons8-add-shopping-cart.svg',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AddProducts();
                }));
              },
              text: "Add Products",
            ),
            decoration: BoxDecoration(
                gradient: gradient2,
                boxShadow: [kDefaultShadow],
                borderRadius: BorderRadius.circular(size.width * 0.03),
                color: containerColors),
          ),
        ],
      ),
    );
  }
}

class gridViewColumn extends StatelessWidget {
  gridViewColumn({this.text, this.onPressed, this.svgicondir});
  final String text;
  final String svgicondir;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      onPressed();
                    },
                    child: Container(child: SvgPicture.asset(svgicondir)))),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$text',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 23, color: Colors.white)),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

void snackbarOFitems(
    {BuildContext context,
    Size size,
    String textchoice1,
    String textChoice2,
    Function functionforProducts,
    Function functionforStockHistory}) {
  SnackBar snackbar = SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: colorforall,
      elevation: 6,
      content: Container(
        height: size.height * 0.2,
        child: Column(
          children: [
            Expanded(
              child: listTileofSnackbar(
                listTileIcon: Icons.web_asset,
                functionPressed: functionforProducts,
                text: "${textchoice1}",
                sizeData: size,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Expanded(
              child: listTileofSnackbar(
                listTileIcon: Icons.history,
                functionPressed: functionforStockHistory,
                text: "${textChoice2}",
                sizeData: size,
              ),
            )
          ],
        ),
      ));

  Scaffold.of(context).showSnackBar(snackbar);
}

class listTileofSnackbar extends StatelessWidget {
  listTileofSnackbar(
      {this.sizeData,
      this.text,
      this.listTileIcon,
      Key key,
      this.functionPressed})
      : super(key: key);

  Size sizeData;
  final String text;
  IconData listTileIcon;
  Function functionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [kDefaultShadow],
            color: containerColors,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListTile(
          onTap: functionPressed,
          trailing: Text(text,
              style: TextStyle(
                  color: Colors.black, fontSize: sizeData.height * 0.02)),
          leading: IconButton(
            icon: Icon(
              listTileIcon,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ));
  }
}
