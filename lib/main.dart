import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/LoginFeatures/LoginScreen.dart';
import 'Screens/HomeScreen.dart';
import 'dart:async';
import 'package:inventory_management_system/Screens/LoginFeatures/LoginScreen.dart';
import 'package:get/get.dart';

void main() async {
  runApp(InventoryApp());
  await Firebase.initializeApp();
}

class InventoryApp extends StatefulWidget {
  @override
  _InventoryAppState createState() => _InventoryAppState();
}

class _InventoryAppState extends State<InventoryApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.loginScreen,
      
      routes: {
        LoginScreen.loginScreen: (context) => LoginScreen(),
        HomeScreen.Homescreen: (context) => HomeScreen()
      },
      home: Scaffold(
      
// body file in lib/Screens/HomeScreenComponents/body.dart
        body: HomeScreen(),
      ),
    );
  }
}
