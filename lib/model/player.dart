import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';

class Player {
  final String name;
  final bool isPlayer;
  List<MyCard> inHand = [];
  int score = 0;
  bool actionEnded = false;
  int chip = 500;

  bool showScore = true;
  bool isBust = false;
  bool hasStand = false;
  bool gotNaturalBlackJack = false;
  bool hasWon = false;

  Player(this.name, this.isPlayer);
}

Widget displayIcon(playerName) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Padding(
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
              padding: const EdgeInsets.all(0),
              height: 60,
              width: 60,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 58, 118, 229),
                        width: 3),
                    image: DecorationImage(
                      image:
                          AssetImage('assets/img/playerIcon/${playerName}.jpg'),
                      fit: BoxFit.cover,
                    )),
              ))),
    )
  ]);
}

// random color
Color playerTurnReminder() {
  final random = Random();
  final a = random.nextInt(256);
  final r = random.nextInt(256);
  final g = random.nextInt(256);
  final b = random.nextInt(256);
  return Color.fromARGB(a, r, g, b);
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
