import 'package:flutter/material.dart';

class EntryPage extends StatelessWidget{

  EntryPage({
    Key key,
    this.parameter,
    @required this.backgroundColor,
    @required this.textColor,
  }): super(key:key);
  final backgroundColor;
  final textColor;
  final parameter;

  @override
  Widget build(BuildContext context) {
    return new Container(

      color: backgroundColor,
      alignment: Alignment.center,

      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "\nWitaj Pracowniku!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: textColor,
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
