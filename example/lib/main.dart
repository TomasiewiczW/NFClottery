import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

import 'EntryPage.dart';
import 'LotteryPage.dart';
import 'ImportImages.dart';
import 'Lottery.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //should i remove some variables from here?
  NfcData _nfcData;
  PageController _controller;
  TimeOfDay _timeOfScan = new TimeOfDay(hour: 0, minute: 0);
  Color rekordColorGreen = const Color(0xff254B34);
  Color rekordColorWhite = const Color(0xffffffff);
  int numberOfSameImgs;
  List<Image> lotteryImgs = new List<Image>();
  List<Image> drawnImgs = new List<Image>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      //DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    numberOfSameImgs = 0;
    lotteryImgs = importImg();
    drawnImgs.add(lotteryImgs[1]);
    drawnImgs.add(lotteryImgs[1]);
    drawnImgs.add(lotteryImgs[2]);
    _controller = new PageController();

    startNFC();
  }

  Future<void> menuAnimate(int destinatedPage, int durationInSeconds)async{
    return _controller.animateToPage(
      destinatedPage,
      duration: new Duration(seconds: durationInSeconds),
      curve: Curves.easeIn,
    );
  }
  //should i move this future to another class?
  Future<void> startNFC() async {
    setState(() {
      _nfcData = NfcData();
      _nfcData.status = NFCStatus.reading;
    });

    FlutterNfcReader.read.listen((response) {
      setState(() {
        drawnImgs = drawYourLuck(3, lotteryImgs);
        numberOfSameImgs = numberOfSameImages(drawnImgs);
        _nfcData = response;
        _timeOfScan = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
        menuAnimate(1, 1);
        var future = new Future.delayed(new Duration(seconds: 5), (){});
        future.then((a){
          menuAnimate(0, 1);
        });
      });
    });
  }

  Future<void> stopNFC() async {
    NfcData response;

    try {
      print('NFC: Stop scan by user');
      response = await FlutterNfcReader.stop;
    } on PlatformException {
      print('NFC: Stop scan exception');
      response = NfcData(
        id: '',
        content: '',
        error: 'NFC scan stop exception',
        statusMapper: '',
      );
      response.status = NFCStatus.error;
    }

    setState(() {
      _nfcData = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              new EntryPage(
                textColor: rekordColorWhite,
                backgroundColor: rekordColorGreen,
              ),
              new LotteryPage(
                nfcData: _nfcData,
                timeOfScan: _timeOfScan,
                numberOfSameImgs: numberOfSameImgs,
                drawnImgs: drawnImgs,
                textColor: rekordColorWhite,
                backgroundColor: rekordColorGreen,
              ),
            ],
          )

          ),
    );
  }
}



