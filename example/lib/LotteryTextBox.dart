import 'package:flutter/material.dart';

class LotteryTextBox extends StatelessWidget{

  LotteryTextBox({
    Key key,
    this.parameter,
    @required this.nfcData,
    @required this.timeOfScan,
    @required this.numberOfSameImgs,
    @required this.textColor,
  }): super(key:key);
  final parameter;
  final nfcData;
  final timeOfScan;
  final numberOfSameImgs;
  final textColor;

  @override
  Widget build(BuildContext context) {
    return new
    RichText(

        textAlign: TextAlign.center,
        text: TextSpan(
            text: "\nDziękujemy!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: textColor,
            ),

            children: <TextSpan>[
              TextSpan(
                  text: nfcData != null ? '\nWitaj $nfcData' : '',
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
              ),
              TextSpan(
                  text: "\n"+ (numberOfSameImgs == 0 ? 'Kiedyś się uda': (numberOfSameImgs == 1 ? 'Było blisko' : 'Szczęście Ci sprzyja!')),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )
              )
            ]
        )

    );

  }
}
