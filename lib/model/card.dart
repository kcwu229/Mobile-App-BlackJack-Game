// ignore_for_file: prefer_typing_uninitialized_variables, unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/suit.dart';
import 'package:flutter_blackjack/pages/number.dart';

class MyCard extends StatelessWidget {
// Basic setting
  final suit;
  final number;
  final showBack;

  MyCard({this.suit, this.number, this.showBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              padding: const EdgeInsets.all(5),
              color: Colors.white,
              height: 90,
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text('$number'),
                  ]),
                  suit,
                  Transform.rotate(
                      angle: pi,
                      child: Row(children: [
                        Text('$number'),
                      ]))
                ],
              )),
        ));
  }
}
