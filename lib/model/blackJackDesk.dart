import 'package:flutter/material.dart';

Widget label(width, height, text) {
  return Container(
    alignment: Alignment.center,
    width: width,
    height: height,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 5),
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
  );
}

Widget chipArea(chip) {
  return Stack(children: [
    Transform(
      transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Text(
          'Bet here',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
    chip,
  ]);
}

Widget cardArea() {
  return Stack(children: [
    Transform(
      transform: Matrix4.identity()..translate(60.0, -3.0, 0.0),
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
        ),
      ),
    ),
  ]);
}
