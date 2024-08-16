import 'package:flutter/material.dart';

dynamic blackColor = Colors.black;
dynamic redColor = Colors.red;
double fontSize = 14.0;

Map<String, dynamic> suitPattern = {
  'spade': [
    '♠',
    [blackColor, fontSize]
  ],
  'heart': [
    '❤',
    [redColor, fontSize]
  ],
  'club': [
    '♣',
    [blackColor, fontSize]
  ],
  'diamond': [
    '♦',
    [redColor, fontSize]
  ]
};

Widget suitMap(suit) {
  return Text(suitPattern[suit][0],
      style: TextStyle(
          color: suitPattern[suit][1][0], fontSize: suitPattern[suit][1][1]));
}
