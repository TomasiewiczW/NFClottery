import 'package:flutter/material.dart';
import 'LotteryTextBox.dart';
import 'LotteryImagesBox.dart';

class LotteryPage extends StatelessWidget{

  LotteryPage({
    Key key,
    this.parameter,
    @required this.nfcData,
    @required this.timeOfScan,
    @required this.numberOfSameImgs,
    @required this.drawnImgs,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.scrollController,
  }): super(key:key);
  final nfcData;
  final timeOfScan;
  final numberOfSameImgs;
  final drawnImgs;
  final backgroundColor;
  final textColor;
  final parameter;
  final scrollController;

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: backgroundColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new LotteryTextBox(nfcData: nfcData, timeOfScan: timeOfScan, numberOfSameImgs: numberOfSameImgs, textColor: textColor,),
            new LotteryImageBoxWidget(drawnImgs: this.drawnImgs, gapSize: 5.0, scrollController: scrollController,),

          ],

        )


    );
  }

}
