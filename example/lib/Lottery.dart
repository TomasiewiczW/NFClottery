import 'dart:math';

import 'package:flutter/material.dart';


class RandomImg{
  List<Image> importedImages;
  List<Image> drawnImages;

  RandomImg(){
    importedImages = importImg();
    drawnImages = _drawYourLuck(3, importedImages);
}
  void drawAgain(){
    drawnImages = _drawYourLuck(drawnImages.length, importedImages);
  }
  List<Image> importImg(){
    List<Image> l = new List<Image>{
      new Image(image: AssetImage('img/bbq4it.png')),
      new Image(image: AssetImage('img/ratusz.png')),
      new Image(image: AssetImage('img/centrumSzkoleniowe.png')),
      new Image(image: AssetImage('img/szkolaSportowa.png')),
      new Image(image: AssetImage('img/towarzystwoSportowe.png'))
    };
    return l;
  }

  Image findRandomImg( List<Image> l){
    Random r = new Random();
    return l[r.nextInt(l.length-1)];
  }

  int numberOfSameImages(){
    int n = 0;
    for(int i = 0; i < drawnImages.length; i++){
      for(int j = i + 1; j < drawnImages.length; j++){
        if(drawnImages[i].image.toString()==drawnImages[j].image.toString()) n++;
        //if all same, return
        if(n==2) return n;
      }
    }
    return n;
  }

  List<Image> _drawYourLuck(int numberOfDraws, List<Image> imagesToDraw){
    List<Image> l = new List<Image>{
      findRandomImg(imagesToDraw),
      findRandomImg(imagesToDraw),
      findRandomImg(imagesToDraw)
    };
    return l;
  }
}


