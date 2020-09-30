import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';



enum ScanActions { Scan }

class ImsBlocData {
  final _stateStreamController = StreamController<String>();

  StreamSink<String> get barCodeSink => _stateStreamController.sink;
  Stream<String> get barCodeStream => _stateStreamController.stream;

  final _eventStateController = StreamController<ScanActions>();

  StreamSink<ScanActions> get eventBarCodeSink => _eventStateController.sink;

  Stream<ScanActions> get eventBarCodeStream => _eventStateController.stream;

  dynamic scanFunction() async {
    var result = await BarcodeScanner.scan();

    return result.rawContent;
  }

  BlocIms() {
    String scannedData = "";
    eventBarCodeStream.listen((event) async {
      if (event == ScanActions.Scan) {
        scannedData = await scanFunction();
      }

      barCodeSink.add(scannedData);
    });
  }
}
