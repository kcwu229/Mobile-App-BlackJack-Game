import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/deck.dart';

Widget showScore(score, showScore) {
  return Offstage(
    child: Container(
      child: Text('${score}'),
    ),
    offstage: !showScore,
  );
}
