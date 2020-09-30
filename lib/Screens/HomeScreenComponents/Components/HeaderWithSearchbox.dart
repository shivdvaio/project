import 'package:flutter/material.dart';
import 'package:inventory_management_system/Data/constant.dart';


class headeWithSearchBox extends StatelessWidget {
  const headeWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding),
            child: Row(children: [
              Text(
                "Inventory \n Mangement System",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              
             
            ]),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(36),
                    bottomLeft: Radius.circular(36)),
                color: colorforall),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Search Product",
                            hintStyle: TextStyle(
                                color: kPrimaryColor.withOpacity(0.8))),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor.withOpacity(0.7),
                          blurRadius: 50,
                          offset: Offset(0, 10))
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
