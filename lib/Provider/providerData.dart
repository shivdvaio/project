import 'package:flutter/material.dart';

class ListViewOfProductsProvider extends ChangeNotifier {
  int value1 = 0;
  List listofvalues = [];
  Map mapdata = {};
  List listofkey = [];
  

  void Increament() {
    value1++;
    notifyListeners();
  }

  void Decreament() {
    value1--;
    notifyListeners();
  }

  void valueTo0ne() {
    value1 = 1;
  }

  Map maptoList(Map mapData) {
    mapdata.addAll(mapData);
  }

  void Value1Reset() {
    value1 = 0;
  }

 
  void get increament => Increament();

  void get decreament => Decreament();

  int get getIntvalue => value1;

  Map get getmapvalue => mapdata;

 
}
