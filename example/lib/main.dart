import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Service _service = new Service();
  Color rekordColorGreen = const Color(0xff254B34);
  Color rekordColorWhite = const Color(0xffffffff);

  String _nameBondedToNfcCode;

  RandomImg images = new RandomImg();

  PageController _controller;
  DateTime _timeOfScan = new DateTime(2019);
  int numberOfSameImgs;

  List<ScrollController> lotteryControllers= new List<ScrollController>();
  
  TextEditingController textEditingController = new TextEditingController(text: '');

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

    //necessary scrollControllers adjustment
    for(int i = 0; i < 3; ++i) lotteryControllers.add(new ScrollController(initialScrollOffset: 10));

    lotteryPage = new LotteryPage(
      nfcData: _nameBondedToNfcCode,
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

    listenForNfcTagReading();
    super.initState();
  }

  Future<void> menuAnimate(int destinatedPage, int durationInSeconds)async{
    return _controller.animateToPage(
      destinatedPage,
      duration: new Duration(seconds: durationInSeconds),
      curve: Curves.easeIn,
    );
  }

  Future<void> listenForNfcTagReading() async {
    textEditingController.addListener((){
      if(textEditingController.text!='')
      setState(() {
        _service.findUserByNfcCode(int.parse(textEditingController.text));

        _nameBondedToNfcCode = _service.scannedPerson.FirstName + " " + _service.scannedPerson.LastName;
        _timeOfScan = DateTime.now();

        //problem with timezone probably
        _timeOfScan.add(new Duration(hours: 2));

        _service.addUser(_service.scannedPerson.FirstName, _service.scannedPerson.LastName,
            "${_timeOfScan.day}-${_timeOfScan.month}-${_timeOfScan.year} ${_timeOfScan.hour}:${_timeOfScan.minute}:${_timeOfScan.second}");

        images.drawAgain();
        numberOfSameImgs = images.numberOfSameImages();
        
        
        //sequence of menu movement
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
                textEditingController.text = '';
                menuAnimate(0, 1);
              });
            });
          });
        });
      });
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
              nfcData: _nameBondedToNfcCode,
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



