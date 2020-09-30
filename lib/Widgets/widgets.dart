import 'package:flutter/material.dart';
import 'package:inventory_management_system/Data/data.dart';

class textfiledOfLogin extends StatelessWidget {
  textfiledOfLogin(
      {this.hintext, this.textInputType, this.obsecureValue, this.icon});

  final String hintext;
  final TextInputType textInputType;
  final bool obsecureValue;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 55,
      child: TextField(
        obscureText: obsecureValue,
        keyboardType: textInputType,
        decoration: InputDecoration(
            prefixIcon: icon,
            border: InputBorder.none,
            hintText: "$hintext",
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.7),
            )),
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xffd6e0f0).withOpacity(0.6),
                blurRadius: 10,
                offset: Offset(0, 1))
          ]),
    );
  }
}



class ButtonContainer extends StatelessWidget {
  ButtonContainer({this.text,this.function});
  Function function;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color(0xfff6f5f5)),
      child: FlatButton(
        onPressed: function,
        child: Text(
          "$text",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}



class SignWithIcons extends StatelessWidget {
 SignWithIcons({this.IconDir,this.btnFucntion});
 final String IconDir;
 Function btnFucntion;

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: IconButton(
        icon: Image.asset(IconDir), onPressed: btnFucntion,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.white),
    );
  }
}

