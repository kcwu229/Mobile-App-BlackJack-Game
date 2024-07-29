import 'package:flutter/material.dart';
import 'package:flutter_blackjack/pages/card.dart';
import 'package:flutter_blackjack/pages/cardBack.dart';

// one of the function on mainPage
class QuickGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [MyCard(), MyCard()],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Row(
                        children: [MyCard(), MyCard()],
                      ),
                    ),
                  ),
                  // Deck for drawing card
                  CardBack(),
                  Container(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Row(
                        children: [MyCard(), MyCard()],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [MyCard(), MyCard()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
