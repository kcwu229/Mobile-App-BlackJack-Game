import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';

class Player {
  final String name;
  final bool isPlayer;
  List<MyCard> inHand = [];
  int score = 0;
  bool actionEnded = true;
  int chip = 500;
  bool hasBet = false;
  bool myTurn = false;

  bool showScore = true;
  bool isBust = false;
  bool hasStand = false;
  bool gotNaturalBlackJack = false;
  bool hasWon = false;

  Player(this.name, this.isPlayer);
}

Widget displayStatus(statusList) {
  return Transform(
      transform: Matrix4.identity()..translate(-42.0, 0.0, 0.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Opacity(
            opacity: statusList[0] ? 1.0 : 0.0,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: RichText(
                    text: TextSpan(
                        text: statusList[1],
                        style: TextStyle(
                            backgroundColor: Colors.red,
                            color: Colors.white,
                            fontSize: 20)))))
      ]));
}

Widget displayBust(opacityLevel, text, status) {
  return Positioned(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Opacity(
        opacity: opacityLevel ? 1.0 : 0.0,
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: RichText(
                text: TextSpan(
                    text: text,
                    style: TextStyle(
                        backgroundColor: Colors.red,
                        color: Colors.white,
                        fontSize: 20)))))
  ]));
}
