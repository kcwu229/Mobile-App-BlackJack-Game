import 'package:flutter/material.dart';

Widget chips() {
  return Stack(children: [
    Transform(
      transform: Matrix4.identity()..translate(20.0, 20.0, 0.0),
      child: Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Text(
          '50',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    )
  ]);
}
