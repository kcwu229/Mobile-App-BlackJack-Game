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
  bool myTurn = false;

  bool showScore = true;
  bool isBust = false;
  bool hasStand = false;
  bool gotNaturalBlackJack = false;
  bool hasWon = false;

  Player(this.name, this.isPlayer);
}

Widget displayStatus(opacityLevel, text) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Opacity(
        opacity: opacityLevel ? 1.0 : 0.0,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: RichText(
                text: TextSpan(
                    text: text,
                    style: TextStyle(
                        backgroundColor: Colors.blue,
                        color: Colors.white,
                        fontSize: 20)))))
  ]);
}

Widget displayBust(opacityLevel, text) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Opacity(
        opacity: opacityLevel ? 1.0 : 0.0,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: RichText(
                text: TextSpan(
                    text: text,
                    style: TextStyle(
                        backgroundColor: Colors.red,
                        color: Colors.white,
                        fontSize: 20)))))
  ]);
}
