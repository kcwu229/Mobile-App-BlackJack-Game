// ignore_for_file: prefer_typing_uninitialized_variables, unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/cardUI.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/suit.dart';
import 'package:flutter_blackjack/pages/number.dart';

class MyCard extends StatelessWidget {
// Basic setting
  final suit;
  final rank;
  bool showFace = true;

  String get Rank => rank;
  List get getCardInfo => [suit, rank];

  MyCard({this.suit, this.rank});

  int compareTo(MyCard other) {
    final rankValues = [
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      'J',
      'Q',
      'K',
      'A'
    ];
    return rankValues
        .indexOf(this.rank)
        .compareTo(rankValues.indexOf(other.rank));
  }

  @override
  Widget build(BuildContext context) {
    // UI of the card displayed
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.black, width: 1)),
        height: 90,
        width: 65,
        child: cardFront(rank, suit));
  }
}

// card displayed On desk one by one
Widget displayCard(List<MyCard> cards, player) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Stack(alignment: Alignment.center, children: [
      for (int i = 0; i < cards.length; i++)
        Transform(
            transform: Matrix4.identity()
              ..translate(28.0 * (i), 0.0 * (i), 0.0 * (i)),
            child: Container(
              child: (cards[i].showFace) ? cards[i] : cardBack(),
            )),
    ])
  ]);
}
