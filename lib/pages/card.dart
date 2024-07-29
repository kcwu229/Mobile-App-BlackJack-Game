import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/pages/suit.dart';
import 'package:flutter_blackjack/pages/number.dart';

class MyCard extends StatelessWidget {
// Basic setting
  final suit;
  final color;
  final number;

  MyCard({this.suit, this.color, this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              height: 90,
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: number,
                  ),
                  suit,
                  Transform.rotate(
                      angle: pi,
                      child: Row(
                        children: number,
                      ))
                ],
              )),
        ));
  }
}
