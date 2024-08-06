import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blackjack/model/card.dart';

class playerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              width: 60,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    image: DecorationImage(
                        image: AssetImage('assets/img/playerIcon/icon.jpeg'))),
              ))),
    );
  }
}
