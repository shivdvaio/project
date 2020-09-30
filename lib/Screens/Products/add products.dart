import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../HomeScreen.dart';
import 'ProductsList.dart';
import 'package:get/get.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

String url;
String barcodeValue;
String productDescription;
String locationOfProduct;
String productCategory;
String productName = "";
String addProductTime;
String addProductDate;
String imageURL;

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

// String readTimestamp(int timestamp) {

// }

class _AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorforall,
          title: Text("Add Product"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: SvgPicture.asset('assets/icons/back.svg',
                    color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
          elevation: 0,
        ),
        backgroundColor: colorforall,
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File _imageFile;

  String scanData;

  void _scanfunc() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      scanData = result.rawContent.toString();
      barcodeValue = scanData;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void addProductdataTofireBase(Map mapdata) {
// ignore: deprecated_member_use
    CollectionReference collectionReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('ProductInformation');

    collectionReference.add(mapdata).catchError((e) {
      print(e.toString());
    });
    print("Product Information Added");
  }

  //function for getting date and time of local device
  void dateAndtimeGetter() {
    var now = new DateTime.now();

    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    setState(() {
      addProductTime = formattedTime;

      addProductDate = formattedDate;
    });
  }

// for uploading product image to server

  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://inventory-management-sys-2b487.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() async {
    /// Unique file name for the file
    String filePath = 'images/${addProductTime}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
    });
  }

  void updatedata() async {
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL() as String;

    setState(() {
      imageURL = downloadUrl;
    });
    Map<String, String> mapDataofProducts = {
      "ProductName": productName ?? "Wait",
      "ProductDescription": productDescription ?? "Wait",
      "ProductScanValue": barcodeValue ?? "Wait",
      "ProductCategory": productCategory ?? "Wait",
      "ProductLocation": locationOfProduct ?? "Wait",
      "AddProducttime ": addProductTime ?? "Wait",
      "AddProductDate": addProductDate ?? "Wait",
    };

    mapDataofProducts['imageLink'] = imageURL ?? "Image Loading1";
    print(mapDataofProducts);
    addProductdataTofireBase(mapDataofProducts);
    mapDataofProducts.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> dataoflist = [
      Itemsofoptions(
          buttonFunction: () {
            _scanfunc();
          },
          btnname: "Scan",
          scannerData: scanData,
          size: size,
          text: "Scan Product Bar Code",
          imageProvider: AssetImage('assets/images/icons8-barcode-100.png')),
      Itemsofoptions(
          buttonFunction: () {
            dateAndtimeGetter();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('Options'),
                      content: Container(
                        height: 150,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: kPrimaryColor.withOpacity(0.3)),
                              child: FlatButton(
                                  onPressed: () {
                                    _pickImage(ImageSource.camera);
                                  },
                                  child: Text("Select From Camera")),
                            ),
                            SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: kPrimaryColor.withOpacity(0.3)),
                              child: FlatButton(
                                  onPressed: () {
                                    _pickImage(ImageSource.gallery);
                                  },
                                  child: Text("Select From Gallery")),
                            ),
                            SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: kPrimaryColor.withOpacity(0.3)),
                              child: FlatButton(
                                  onPressed: () {
                                    _cropImage();
                                  },
                                  child: Text("Crop Image")),
                            ),
                            SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: kPrimaryColor.withOpacity(0.3)),
                              child: FlatButton(
                                  onPressed: () {
                                    _clear();
                                  },
                                  child: Text("Clear Image")),
                            ),
                          ]),
                        ),
                      ),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Submit"))
                      ]);
                });
          },
          btnname: "Upload Image",
          size: size,
          text: "Product Image",
          scannerData: "",
          imageProvider: _imageFile == null
              ? AssetImage('assets/images/sanitizer.png')
              : FileImage(File(_imageFile.path))),
      OptionsCard(),
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white,width: 2),
               color: Color(0xff64958f).withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: FlatButton(
           
              onPressed: () {
                dateAndtimeGetter();
                if (_imageFile != null && productName != "") {
                  _startUpload();
                  updatedata();
                  showDialog(
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            FlatButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (_uploadTask.isSuccessful) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsList()));
                                  } else {
                                    Navigator.pop(context);
                                  }
                                })
                          ],
                          title: Text("Product Upload Progess"),
                          content: StreamBuilder<StorageTaskEvent>(
                              stream: _uploadTask.events,
                              builder: (_, snapshot) {
                                var event = snapshot?.data?.snapshot;

                                double progressPercent = event != null
                                    ? event.bytesTransferred /
                                        event.totalByteCount
                                    : 0;

                                return Container(
                                  height: 80,
                                  child: Column(
                                    children: [
                                      if (_uploadTask.isComplete)
                                        Text('🎉🎉🎉'),
                                      if (_uploadTask.isPaused)
                                        FlatButton(
                                          child: Icon(Icons.play_arrow),
                                          onPressed: _uploadTask.resume,
                                        ),
                                      if (_uploadTask.isInProgress)
                                        FlatButton(
                                          child: Icon(Icons.pause),
                                          onPressed: _uploadTask.pause,
                                        ),

                                      // Progress bar
                                      LinearProgressIndicator(
                                          backgroundColor: kPrimaryColor,
                                          value: progressPercent),
                                      Text(
                                          '${(progressPercent * 100).toStringAsFixed(2)} % '),
                                    ],
                                  ),
                                );
                              }),
                        );
                      },
                      context: context);
                }
              },
              child: Text("Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))))
    ];
    return Column(children: [
      SearchBox(),
      CategoryList(),
      SizedBox(
        height: kDefaultPadding / 2,
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48)),
                  color: colorforall,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: dataoflist.length,
                  itemBuilder: (context, index) {
                    return dataoflist[index];
                  }),
            ),
          ],
        ),
      )
    ]);
  }

  Container SearchBox() {
    return Container(
      child: TextField(
        style: TextStyle(color: Colors.white, fontSize: 17),
        onChanged: (value) {
          setState(() {
            productName = value;
          });
        },
        decoration: InputDecoration(
            hintText: "Input Product Name",
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            icon: SvgPicture.asset('assets/icons/search.svg'),
            border: InputBorder.none),
      ),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.4)),
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 4),
      margin: EdgeInsets.all(kDefaultPadding),
    );
  }
}

class Itemsofoptions extends StatelessWidget {
  String imageDir;
  String text;
  String btnname;
  Function buttonFunction;
  dynamic scannerData;
  ImageProvider imageProvider;

  Itemsofoptions({
    this.imageDir,
    this.text,
    this.btnname,
    this.buttonFunction,
    this.scannerData,
    this.imageProvider,
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white)),
            decoration: BoxDecoration(
                boxShadow: [kDefaultShadow],
                color: kPrimaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(22)),
            height: 150,
          ),
          Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: imageProvider),
                decoration: BoxDecoration(
                  
                  shape: BoxShape.circle),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 100,
                width: 150,
              )),
          Positioned(
              left: 0,
              bottom: 0,
              height: 136,
              width: size.width - 130,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Text("${text}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 13),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Text("${scannerData ?? ''}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: buttonFunction,
                      child: Container(
                        child: Text(
                          "${btnname}",
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(21),
                            ),
                            color: colorforall.withOpacity(0.5)),
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 2, vertical: 10),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
      height: 160,
      margin: EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
    );
  }
}

class OptionsCard extends StatefulWidget {
  @override
  _OptionsCardState createState() => _OptionsCardState();
}

class _OptionsCardState extends State<OptionsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            
            child: Container(
                child: Container(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(" Product Description",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                productCategory = value;
                              });
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.category_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                hintText: "Input Category",
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(17)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17)),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: colorforall.withOpacity(0.3))
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                locationOfProduct = value;
                              });
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.home_outlined,
                                    color: Colors.black, size: 30),
                                hintText: "Location",
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(17)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17)),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: colorforall.withOpacity(0.3)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                productDescription = value;
                              });
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.description_rounded,
                                    color: Colors.black, size: 30),
                                hintText: "Description",
                                hintStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(17)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(17)),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: colorforall.withOpacity(0.3)),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white)),
            decoration: BoxDecoration(
                boxShadow: [kDefaultShadow],
                color: colorforall.withOpacity(0.3),
                borderRadius: BorderRadius.circular(22)),
            height: 400,
          ),
        ],
      ),
      height: 250,
      margin: EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultPadding / 2),
    );
  }
}

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int intialIndex = 0;
  List<String> items = [
    "Product List",
    "Stock In",
    "Stock Out",
    "Add Products",
    "Scan Bar Code"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              intialIndex = index;
            });
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: index == items.length - 1 ? kDefaultPadding : 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: index == intialIndex
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    items[index],
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ))),
        ),
      ),
    );
  }
}
