import 'package:flutter/material.dart';

class LotteryImageBoxWidget extends StatelessWidget{
  LotteryImageBoxWidget({
    @required this.drawnImgs,
    @required this.gapSize,
    @required this.scrollController,
    Key key,
    this.parameter,
  }): super(key:key);
  final parameter;
  final drawnImgs;
  final gapSize;
  final scrollController;



  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 190,
          height: 190,
          child: new ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            controller: scrollController[0],
            children: <Widget>[
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
            ],

          ),
        ),
        //new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 0,),
        Container(
          width: this.gapSize,
        ),
        Container(
          width: 190,
          height: 190,
          child: new ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            controller: scrollController[1],
            children: <Widget>[
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
            ],

          ),
        ),
        Container(
          width: this.gapSize,
        ),
        Container(
          width: 190,
          height: 190,
          child: new ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            controller: scrollController[2],
            children: <Widget>[
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
              new LotteryImageWidget(drawnImgs: this.drawnImgs, drawnImgsIndex: 1,),
            ],

          ),
        ),
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
              width: 10.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: drawnImgs[drawnImgsIndex].image,
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}