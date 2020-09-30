import 'package:flutter/material.dart';

class Content {
  Content({this.assetName, this.text});
  final String text;
  final String assetName;
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});

  String title;
  IconData icon;
}
