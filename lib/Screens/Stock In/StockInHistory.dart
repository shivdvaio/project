import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Screens/HomeScreen.dart';

class StockInhistory extends StatefulWidget {
  @override
  _StockInhistoryState createState() => _StockInhistoryState();
}

class _StockInhistoryState extends State<StockInhistory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: colorforall,
          appBar: AppBar(
              centerTitle: true,
              title: Text("Stock in History",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Get.to(HomeScreen());
                  },
                )
              ],
              elevation: 0,
              backgroundColor: colorforall),
          body: SafeArea(
            child: StreamBuilder(
                // ignore: deprecated_member_use
                stream:
                    Firestore.instance.collection('stockindata').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null)
                    return CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    );
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "Stock In Date",
                                        style: stockinHistoryListTile,
                                      ),
                                      trailing: Text(
                                          '${snapshot.data.docs[index].data()['Date']}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text("Stock In Time",
                                          style: stockinHistoryListTile),
                                      trailing: Text(
                                          '${snapshot.data.docs[index].data()['Time']}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        trailing: Text(
                                          snapshot.data.docs[index]
                                              .data()
                                              .values
                                              .toString()
                                              .replaceRange(0, 1, "")
                                              .replaceAll("Date,", "")
                                              .replaceAll("Time", "")
                                              .replaceAll(",", "")
                                              .replaceAll(")", "")
                                              .substring(0, 1),
                                          style: stockinHistoryListTile,
                                        ),
                                        title: Text(
                                            ' Stock In ${snapshot.data.docs[index].data().keys.toString().replaceRange(0, 1, "").replaceAll("Date,", "").replaceAll("Time", "").replaceAll(",", "").replaceAll(")", "").replaceAll("Date", "")}',
                                            style: stockinHistoryListTile)),
                                  ),
                                  ListTile(
                                    title: IconButton(
                                        onPressed: () async {
                                          // ignore: deprecated_member_use
                                          await Firestore.instance
                                              .runTransaction((Transaction
                                                  myTransaction) async {
                                            await myTransaction.delete(snapshot
                                                .data
                                                // ignore: deprecated_member_use
                                                .documents[index]
                                                .reference);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22)),
                                  boxShadow: [kDefaultShadow])),
                        );
                      });
                }),
          ),
        ));
  }
}
