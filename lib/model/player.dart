import 'dart:ffi';

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
