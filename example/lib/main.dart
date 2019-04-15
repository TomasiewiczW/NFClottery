import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

import 'EntryPage.dart';
import 'LotteryPage.dart';
import 'Lottery.dart';
import 'Service.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  //should i remove some variables from here?
  Service _service = new Service();

  String _nfcData;
  Color rekordColorGreen = const Color(0xff254B34);
  Color rekordColorWhite = const Color(0xffffffff);

  RandomImg images = new RandomImg();

  PageController _controller;
  DateTime _timeOfScan = new DateTime(2019);
  int numberOfSameImgs;

  List<ScrollController> lotteryControllers= new List<ScrollController>();
  
  TextEditingController textEditingController = new TextEditingController();


  LotteryPage lotteryPage;
  EntryPage entryPage;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    numberOfSameImgs = 0;


    _controller = new PageController();

    for(int i = 0; i < 3; ++i){
      lotteryControllers.add(new ScrollController(initialScrollOffset: 10));
    }
    lotteryPage = new LotteryPage(
      nfcData: _nfcData,
      timeOfScan: _timeOfScan,
      numberOfSameImgs: numberOfSameImgs,
      randomImages: images,
      textColor: rekordColorWhite,
      backgroundColor: rekordColorGreen,
      scrollController: lotteryControllers,
    );

    entryPage = new EntryPage(
      textColor: rekordColorWhite,
      backgroundColor: rekordColorGreen,
      textEditingController: textEditingController,
    );

    startNFC();
    super.initState();
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
    });
    textEditingController.addListener((){
      if(textEditingController.text!='')
      setState(() {
        //_nfcData = textEditingController.text;

        //var a = _service.findUserByNfcCode(textEditingController.text);

        _service.findUserByNfcCode("3679236004");
        _nfcData = _service.scannedPerson.FirstName + " " + _service.scannedPerson.LastName;
        _timeOfScan = DateTime.now();
        _timeOfScan.add(new Duration(hours: 2));
        print(_timeOfScan);

        _service.addUser(_service.scannedPerson.FirstName, _service.scannedPerson.LastName, "15-04-2019 ${_timeOfScan.hour}:${_timeOfScan.minute}:${_timeOfScan.second}");

        images.drawAgain();
        numberOfSameImgs = images.numberOfSameImages();

        menuAnimate(1, 1);

        var future = new Future.delayed(new Duration(seconds: 2), (){});
        future.then((a) {

          lotteryPage.scrollController[0].animateTo(
              1700.0 + 10.0, duration: new Duration(seconds: 5),
              curve: Curves.elasticOut);
          future = new Future.delayed(new Duration(seconds: 1), (){});
          future.then((a) {
            lotteryPage.scrollController[1].animateTo(
                1700.0 + 10.0, duration: new Duration(seconds: 5),
                curve: Curves.elasticOut);
            future = new Future.delayed(new Duration(seconds: 1), (){});
            future.then((a){
              lotteryPage.scrollController[2].animateTo(
                  1700.0 + 10.0, duration: new Duration(seconds: 5),
                  curve: Curves.elasticOut);
              future = new Future.delayed(new Duration(seconds: 10),(){});
              future.then((a){
                menuAnimate(0, 1);
                textEditingController.text = '';
              });
            });
          });
        });
      });
    });
  }
  // how to stop nfc ? and when to stop
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
      _nfcData = textEditingController.text;
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
              entryPage,
            lotteryPage = new LotteryPage(
              nfcData: _nfcData,
              timeOfScan: _timeOfScan,
              numberOfSameImgs: numberOfSameImgs,
              randomImages: images,
              textColor: rekordColorWhite,
              backgroundColor: rekordColorGreen,
              scrollController: lotteryControllers,
            )
            ],
          )

          ),
    );
  }
}



