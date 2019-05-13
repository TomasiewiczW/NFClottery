import 'package:flutter/material.dart';

class LotteryImageBoxWidget extends StatelessWidget{
  LotteryImageBoxWidget({
    @required this.randomImages,
    @required this.gapSize,
    @required this.scrollController,
    Key key,
    this.parameter,
  }): super(key:key);
  final parameter;
  final randomImages;
  final gapSize;
  final scrollController;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 190,
          height: 170,
          child: new ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            controller: scrollController[0],
              final children <Widget>[];
              for(var i = 0; i < 15; i++){
                if(i == 10)
                  children.add(new LotteryImageWidget(drawnImgs: this.randomImages.drawnImages, drawnImgsIndex: 0,),);
                else
                children.add(new LotteryImageWidget(drawnImgs: this.randomImages.importedImages, drawnImgsIndex: i%5,));
              }
          ),
        ),
        Container(
          width: this.gapSize,
        ),
        Container(
          width: 190,
          height: 170,
          child: new ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            controller: scrollController[1],
              final children <Widget>[];
              for(var i = 0; i < 15; i++){
              if(i == 10)
              children.add(new LotteryImageWidget(drawnImgs: this.randomImages.drawnImages, drawnImgsIndex: 1,),);
              else
              children.add(new LotteryImageWidget(drawnImgs: this.randomImages.importedImages, drawnImgsIndex: i%5,));
              }
          ),
        ),
        Container(
          width: this.gapSize,
        ),
        Container(
          width: 190,
          height: 170,
          child: new ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            controller: scrollController[2],
            final children <Widget>[];
            for(var i = 0; i < 15; i++){
            if(i == 10)
            children.add(new LotteryImageWidget(drawnImgs: this.randomImages.drawnImages, drawnImgsIndex: 2,),);
            else
            children.add(new LotteryImageWidget(drawnImgs: this.randomImages.importedImages, drawnImgsIndex: i%5,));
            }

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