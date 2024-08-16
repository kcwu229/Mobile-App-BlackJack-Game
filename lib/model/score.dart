import 'package:flutter/material.dart';

Widget showScore(score, showScore) {
  return Offstage(
    child: Container(
      child: Text('${score}'),
    ),
    offstage: !showScore,
  );
}
