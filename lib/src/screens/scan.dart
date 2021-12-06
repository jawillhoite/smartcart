import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' ;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/link.dart';
import '../data/user.dart' as globals;


Future<String> getPost(barcodeScanRes) async {

  final response = await get(Uri.parse('http://www.brocade.io/api/items/' + barcodeScanRes));

  if (response.statusCode == 200)
  {
    var body = jsonDecode(response.body);
    print(body);
    //List<API> posts = body.map((dynamic item) => API.fromJson(item)).toList();

    return body['name'];

  }
  else {
    throw "Can't get posts.";
  }
}  


// GET API Model
class API {
  final String name;

  API({
    required this.name    
    });

    factory API.fromJson(Map<String, dynamic> json) {
      return API(
        name: json['name'] as String,
      );
    }
}


class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scanBarcode = 'Unknown';
  String _scanName = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    var res = await getPost(barcodeScanRes);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print(res);
      _scanName = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Scanner')),),
      body: Container(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => scanBarcodeNormal(),
              child: const Text('Start barcode scan')),
            
            ElevatedButton(
              onPressed: () => startBarcodeScanStream(),
              child: const Text('Start barcode scan stream')),
            Text('Scan id : $_scanBarcode\n',
              style: const TextStyle(fontSize: 20)),
            Text('Scan name : $_scanName\n',
              style: const TextStyle(fontSize: 20)),
           
          ]
        )
      )          
    );
  }              
}