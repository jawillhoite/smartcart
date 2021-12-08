import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' ;
import 'package:firebase_database/firebase_database.dart';

import 'package:smartcart/src/data/shopping_list.dart';
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
    print('no post');
    return 'Unknown';    
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
  String _scanBarcode = '-1';
  String _scanName = 'Unknown';

  // Reference to the real-time datbase
  final database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      //print(barcodeScanRes);
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
      //print(res);
      _scanName = res;
    });
  }
  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: ( )    {        
              Navigator.pop(context, 'Yes');
              //addItemToList(_scanName);             
            },child: const Text('Yes'),           
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'No'),
            child: const Text('No'),
          ),
        ],
      );
    },
  );
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
            
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Item Detected!'),
                  content: Text('Would you like to add $_scanName to your current cart?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {        
                        Navigator.pop(context, 'Yes');
                        addItemToList(_scanName);             
                      }, child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'No'),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ),
              child: const Text('Add Item'),
            ),
          ]
        )
      )          
    );
  }       
    Future<UserShoppingList> getCurrent() async {
    DataSnapshot data = await database.child('cartList/' + globals.currUser + '/current').once();
    if (data.value != null) {
      return await readList(data.value);
    } else {
      return UserShoppingList('Pick A Current List', [] ,false, true);
    }
  }

  Future<UserShoppingList> readList(listName) async {
    DataSnapshot test = await (database.child('cartList/' + globals.currUser + '/' + listName).once());
    List itemList = [];
    try {
      itemList = test.value['listOfItems'];
    } catch (e) {
      itemList = [];
    }
    return UserShoppingList(listName, itemList ,test.value['favorite'], test.value['current']);
  }
  void addItemToList(L) async {
    var addItem = await getCurrent();
    if (L != '') {
      if (addItem.listOfItems
          .any((listElement) => listElement == L)) {
        return;
      } else {
        List added = [];
        addItem.listOfItems.forEach((element) {
          added.add(element);
        });
        added.add([L,false]);
        await database.child('cartList/' + globals.currUser + '/' + addItem.name + '/listOfItems').set(added);
        
        setState(() {
        });
      }
    }
  }
}