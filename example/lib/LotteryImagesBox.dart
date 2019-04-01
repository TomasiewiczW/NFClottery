import 'package:flutter/material.dart';

class LotteryImageBoxWidget extends StatelessWidget{
  LotteryImageBoxWidget({
    @required this.drawnImgs,
    @required this.gapSize,
    Key key,
    this.parameter,
  }): super(key:key);
  final parameter;
  final drawnImgs;
  final gapSize;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 0,),
        Container(
          width: this.gapSize,
        ),
        new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
        Container(
          width: this.gapSize,
        ),
        new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 2,),
      ],
    );
  }
}

class LotteryImageWidget extends StatelessWidget{
  LotteryImageWidget({
    @required this.drawnImgs,
    @required this.drawnImgsIndex,
    Key key,
    this.parameter,
  }): super(key:key);
  final parameter;
  final drawnImgs;
  final drawnImgsIndex;

  @override
  Widget build(BuildContext context) {
    return new Container(

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 7.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: drawnImgs[drawnImgsIndex].image,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}