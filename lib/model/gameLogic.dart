import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';

class BlackjackGame extends StatefulWidget {
  @override
  _BlackjackGameState createState() => _BlackjackGameState();
}

class _BlackjackGameState extends State<BlackjackGame> {
  List<int> playerHand = [];
  List<int> dealerHand = [];
  int playerScore = 0;
  int dealerScore = 0;
  bool gameOver = false;

// initial start a new game
  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

// draw 2 cards once start
  void _startNewGame() {
    playerHand = _dealCards(2);
    dealerHand = _dealCards(2);
    _calculateScores();
    setState(() {
      gameOver = false;
    });
  }

  List<int> _dealCards(int count) {
    List<int> cards = [];
    Random random = Random();
    for (int i = 0; i < count; i++) {
      int card = random.nextInt(13) + 1;
      cards.add(card);
    }
    return cards;
  }

  void _calculateScores() {
    playerScore = _calculateScore(playerHand);
    dealerScore = _calculateScore(dealerHand);
  }

  int _calculateScore(List<int> hand) {
    int score = 0;
    int aces = 0;
    for (int card in hand) {
      if (card == 1) {
        aces++;
      } else if (card > 10) {
        score += 10;
      } else {
        score += card;
      }
    }
    while (aces > 0 && score + 11 <= 21) {
      score += 11;
      aces--;
    }
    while (aces > 0) {
      score += 1;
      aces--;
    }
    return score;
  }

  void _hit() {
    playerHand.add(_dealCards(1)[0]);
    _calculateScores();
    if (playerScore > 21) {
      _endGame(false);
    }
  }

  void _stand() {
    while (dealerScore < 17) {
      dealerHand.add(_dealCards(1)[0]);
      _calculateScores();
    }
    _endGame(
        playerScore <= 21 && (playerScore > dealerScore || dealerScore > 21));
  }

  void _endGame(bool playerWon) {
    setState(() {
      gameOver = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(playerWon ? '你贏了!' : '你輸了'),
          actions: [
            TextButton(
              onPressed: _startNewGame,
              child: Text('再玩一次'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('二十一點'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('莊家: $dealerScore'),
          SizedBox(height: 16.0),
          Text('玩家: $playerScore'),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _hit,
                child: Text('要牌'),
              ),
              ElevatedButton(
                onPressed: _stand,
                child: Text('停牌'),
              ),
            ],
          ),
          if (gameOver) SizedBox(height: 32.0),
          if (gameOver)
            ElevatedButton(
              onPressed: _startNewGame,
              child: Text('再玩一次'),
            ),
        ],
      ),
    );
  }
}
