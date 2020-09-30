import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:getx_generator/core.dart';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Screens/HomeScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final CollectionReference collectionReference =
      // ignore: deprecated_member_use
      Firestore.instance.collection('ProductInformation');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - 100) / 2;
    final double itemWidth = size.width / 2;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: colorforall,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Products",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: colorforall,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  })
            ],
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                  // ignore: deprecated_member_use
                  stream: Firestore.instance
                      .collection('ProductInformation')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    return new GridView.builder(
                        itemCount: snapshot.data.docs.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                gradient: gradient,
                                borderRadius: BorderRadius.circular(17),
                                color: Color(0xffd6e0f0),
                                boxShadow: [kDefaultShadow]),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                print("hello");
                                              },
                                              child: CachedNetworkImage(
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
                                                        width: 150.0,
                                                        height: 150.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 3),
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 25),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '${snapshot.data.docs[index].data()['ProductScanValue'] ?? "Wait"}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      '${snapshot.data.docs[index].data()['ProductLocation'] ?? "Wait"}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      '${snapshot.data.docs[index].data()['ProductCategory'] ?? "Wait"}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                              '${snapshot.data.docs[index].data()['ProductName'] ?? "Wait"}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          SizedBox(height: 5),
                                          IconButton(
                                              onPressed: ()  async{
                                                // ignore: deprecated_member_use
                                                await Firestore.instance
                                                    .runTransaction((Transaction
                                                        myTransaction) async {
                                                  await myTransaction.delete(
                                                      snapshot
                                                          .data
                                                          .documents[index]
                                                          .reference);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 26,
                                              )),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                )),
          ),
        ));
  }
}
