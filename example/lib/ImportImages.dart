import 'package:flutter/material.dart';

List<Image> importImg(){
  List<Image> l = new List<Image>();
  Image i = new Image(image: AssetImage('img/bbq4it.png'));
  l.add(i);
  i = new Image(image: AssetImage('img/centrumSzkoleniowe.png'));
  l.add(i);
  i = new Image(image: AssetImage('img/ratusz.png'));
  l.add(i);
  i = new Image(image: AssetImage('img/szkolaSportowa.png'));
  l.add(i);
  i = new Image(image: AssetImage('img/towarzystwoSportowe.png'));
  l.add(i);
  return l;
}

