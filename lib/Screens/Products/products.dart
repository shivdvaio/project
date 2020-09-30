import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Data/contentmodel.dart';
import 'package:inventory_management_system/Data/ProductsModel.dart';
import 'package:inventory_management_system/Provider/providerData.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/HomeScreen.dart';
import 'package:inventory_management_system/Screens/Stock%20In/StockInHistory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class ListViewOfProducts extends StatelessWidget {
  void addstockInData(Map mapdata) {
    print(mapdata);
    CollectionReference collectionReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('stockindata');

    collectionReference.add(mapdata).catchError((e) {
      print(e.toString());
    });
    print("Data stock in added");
  }

  Map<String, String> details = {};

  static int data = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListViewOfProductsProvider>(
        create: (context) => ListViewOfProductsProvider(),
        child: Builder(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    var now = new DateTime.now();

                    var formatter = new DateFormat('dd-MM-yyyy');
                    String formattedTime = DateFormat('kk:mm:a').format(now);
                    String formattedDate = formatter.format(now);
                    details['Time'] = formattedTime;
                    details['Date'] = formattedDate;
                    addstockInData(details);
                    details.clear();
                    Get.to(StockInhistory());
                    
                  },
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                elevation: 0,
                centerTitle: true,
                title: Text(" Add Stock In",
                    style: TextStyle(color: Colors.white)),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HomeScreen();
                        }));
                      })
                ],
                backgroundColor: colorforall,
              ),
              backgroundColor: colorforall,
              body: Consumer<ListViewOfProductsProvider>(
                  builder: (context, provider, child) {
                return StreamBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null)
                        return CircularProgressIndicator();
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    color: Color(0xffd6e0f0),
                                    boxShadow: [kDefaultShadow]),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: gradient2),
                                        child: ListTile(
                                            trailing: Text(
                                                '${details[snapshot.data.docs[index].data()['ProductName']] ?? "0"}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 25)),
                                            title: Text(
                                                '${snapshot.data.docs[index].data()['ProductName']}',
                                                style: GoogleFonts.getFont(
                                                    'Cabin',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 30)),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          setState) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Input Stock Quantity"),
                                                      actions: [
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Cancel")),
                                                        FlatButton(
                                                            onPressed: () {
                                                              provider
                                                                  .Value1Reset();

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("submit"))
                                                      ],
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          IconButton(
                                                            color: Colors.red,
                                                            icon:
                                                                Icon(Icons.add),
                                                            onPressed: () {
                                                              provider
                                                                  .increament;
                                                              setState(() {
                                                                data = provider
                                                                    .getIntvalue;
                                                                details['${snapshot.data.docs[index].data()['ProductName']}'] =
                                                                    data.toString();
                                                              });
                                                            },
                                                          ),
                                                          Container(
                                                              child: data > 0
                                                                  ? Text(
                                                                      '${provider.getIntvalue}')
                                                                  : Text('1')),
                                                          IconButton(
                                                            color: Colors.red,
                                                            icon: Icon(Icons
                                                                .remove_circle),
                                                            onPressed: () {
                                                              if (provider
                                                                      .getIntvalue <
                                                                  1) {
                                                                setState(() {
                                                                  provider
                                                                      .valueTo0ne();
                                                                });
                                                              }
                                                              provider
                                                                  .decreament;

                                                              setState(() {
                                                                data = provider
                                                                    .getIntvalue;
                                                                if (data >= 1) {
                                                                  details['${snapshot.data.docs[index].data()['ProductName']}'] =
                                                                      data.toString();
                                                                } else {
                                                                  details['${snapshot.data.docs[index].data()['ProductName']}'] =
                                                                      0.toString();
                                                                }
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: gradient2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                '${snapshot.data.docs[index].data()['imageLink']}',
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                    width: 120.0,
                                                    height: 130.0,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 4),
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    )),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text('Scan Value',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15)),
                                          ),
                                          Expanded(
                                              child: Text(
                                                  '${snapshot.data.docs[index].data()['ProductScanValue']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    // ignore: deprecated_member_use
                    stream: Firestore.instance
                        .collection('ProductInformation')
                        .snapshots());
              }),
            ),
          );
        }));
  }
}
