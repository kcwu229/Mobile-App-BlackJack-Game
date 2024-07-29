import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
// Basic setting

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.white,
        height: 90,
        width: 60,
        child: Image.asset(
          'assets/img/pokerCard/deck.jpg',
        ),
      ),
    );
  }
}
