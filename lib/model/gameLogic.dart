import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/deck.dart';

class GameState {
  // card in hand
  List<MyCard> playerHand = [];
  List<MyCard> dealerHand = [];

  // represent score
  int playerScore = 0;
  int dealerScore = 0;

  // flag for win / lose -- default no
  bool gameOver = false;
  String result = '';

  Deck deck = Deck();

  initState() {
    playerHand.add(deck.drawTwoCard());
    dealerHand.add(deck.drawTwoCard());

    print(playerHand.length);
    print(dealerHand.length);
  }

  //
}
