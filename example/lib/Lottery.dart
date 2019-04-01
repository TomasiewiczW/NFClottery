import 'dart:math';

import 'package:flutter/material.dart';


// fix randomizing not working no class
Image findRandomImg( List<Image> l){
  Random r = new Random();
  return l[r.nextInt(l.length-1)];
}

int numberOfSameImages(List<Image> imgs){
  int n = 0;
  for(int i = 0; i < imgs.length; i++){
    for(int j = i + 1; j < imgs.length; j++){
      if(imgs[i].image.toString()==imgs[j].image.toString()) n++;
      //thrash return, change it pls
      if(n==2) return n;
    }
  }
  return n;
}

List<Image> drawYourLuck(int numberOfDraws, List<Image> imagesToDraw){
  List<Image> l = new List<Image>();
  l.add(findRandomImg(imagesToDraw));
  l.add(findRandomImg(imagesToDraw));
  l.add(findRandomImg(imagesToDraw));
  return l;
}
