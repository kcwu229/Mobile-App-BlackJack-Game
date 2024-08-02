import 'package:flutter/rendering.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'dart:developer' as developer;

enum Suits { spade, heart, club, diamond }

enum Number {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}

class Deck {
  final List<MyCard> deck = [];

// intial create a deck
  Deck() {
    for (final suit in Suits.values) {
      for (final num in Number.values) {
        deck.add(MyCard(suit: suit, number: num));
      }
    }
  }

  // shuffle
  void _shuffle() {
    deck.shuffle();
  }

  // drawing 2 cards in first round
  drawTwoCard() {
    return deck.removeRange(0, 2);
  }

  // drawing 1 card in later round
  drawCard() {
    if (deck.isEmpty) {
      throw Exception('The deck is empty !');
    }
    return deck.removeRange(0, 1);
  }
}
