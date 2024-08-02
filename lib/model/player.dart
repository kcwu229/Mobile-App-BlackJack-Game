import 'dart:ffi';

import 'package:flutter_blackjack/model/card.dart';

class Player {
  final String name;
  final bool isHuman;
  List<MyCard> inHand = [];
  int score = 0;
  bool actionEnded = false;
  int chip = 500;

  bool showScore = true;
  bool bust = false;

  bool naturalBlackJack = false;
  bool stand = false;

  Player(this.name, this.isHuman);
}
