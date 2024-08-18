// ignore_for_file: prefer_typing_uninitialized_variables, unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/suit.dart';
import 'package:flutter_blackjack/pages/number.dart';

class MyCard extends StatelessWidget {
// Basic setting
  final suit;
  final rank;
  final showBack;

  String get Rank => rank;
  List get getCardInfo => [suit, rank, showBack];

  MyCard({this.suit, this.rank, this.showBack});

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
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.black, width: 1)),
        height: 90,
        width: 65,
        child: ClipRRect(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // rank
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(
                            '$rank',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ]),
                        suitMap(suit),
                        Transform.rotate(
                          angle: pi,
                          child: Row(children: [
                            Text(
                              '$rank',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ]),
                        ),
                      ],
                    ))
              ]),
        ));
  }
}

Widget displayCard(List<MyCard> cards) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Stack(alignment: Alignment.center, children: [
      for (int i = 0; i < cards.length; i++)
        Transform(
            transform: Matrix4.identity()
              ..translate(28.0 * (i), 0.0 * (i), 0.0 * (i)),
            child: Container(
              child: cards[i],
            )),
    ])
  ]);
}
