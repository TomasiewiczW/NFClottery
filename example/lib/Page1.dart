import 'package:flutter/material.dart';

class Page1 extends StatelessWidget{
  Color rekordColorGreen = const Color(0xff254B34);
  Color rekordColorWhite = const Color(0xffffffff);

  Page1({
    Key key,
    this.parameter,
  }): super(key:key);

  final parameter;

  @override
  Widget build(BuildContext context) {
    return new Container(

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

    );
  }

}
