import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
// Basic setting

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Container(
        color: Colors.white,
        height: 95,
        width: 65,
        child: Image.asset(
          'assets/img/pokerCard/deck.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
