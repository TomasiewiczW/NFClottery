import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NfcData _nfcData;
  PageController _controller;
  TimeOfDay timeOfScan = new TimeOfDay(hour: 0, minute: 0);
  Color rekordColorGreen = const Color(0xff254B34);
  Color rekordColorWhite = const Color(0xffffffff);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = new PageController();
    startNFC();
  }

  Future<void> startNFC() async {
    setState(() {
      _nfcData = NfcData();
      _nfcData.status = NFCStatus.reading;
    });

    FlutterNfcReader.read.listen((response) {
      setState(() {
        _nfcData = response;
        timeOfScan = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
        menuAnimate(1, 1);
        var future = new Future.delayed(new Duration(seconds: 5), (){});
        future.then((a){
          menuAnimate(0, 1);
        });
      });
    });
  }

  Future<void> menuAnimate(int destinatedPage, int durationInSeconds)async{
    return _controller.animateToPage(
      destinatedPage,
      duration: new Duration(seconds: durationInSeconds),
      curve: Curves.easeIn,
    );
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
              Container(
                color: rekordColorGreen,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "\nWitaj Pracowniku!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: rekordColorWhite,
                    ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\nZbliż telefon z włączonym modułem nfc",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          )
                        )
                      ]
                  )
                ),
              ),
              Container(
                color: rekordColorGreen,
                alignment: Alignment.center,
                child: RichText(
                    textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "\nDziękujemy!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: rekordColorWhite,
                    ),

                    children: <TextSpan>[
                      TextSpan(
                          text: _nfcData != null ? '\nTwój tag nfc to: ${_nfcData.id}' : '',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          )
                      ),
                      TextSpan(
                          text: "\nCzas przybycia to: " + (timeOfScan.minute < 10 ? '${timeOfScan.hour}:0${timeOfScan.minute}' : '${timeOfScan.hour}:${timeOfScan.minute}'),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          )
                      )
                    ]
                  )


                )
              ),

            ],
          )

          ),
    );
  }
}
