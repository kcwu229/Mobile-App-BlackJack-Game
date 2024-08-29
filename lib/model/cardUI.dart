import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/suit.dart';

Widget cardBack() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(0),
    child: Container(
        height: 90,
        width: 65,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/pokerCard/pokerBack.jpg')),
            borderRadius: BorderRadius.circular(13))),
  );
}

Widget cardFront(rank, suit) {
  return ClipRRect(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
  );
}
