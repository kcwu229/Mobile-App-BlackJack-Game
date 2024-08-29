import 'package:flutter_blackjack/model/card.dart';

class Deck {
  final List<MyCard> deck = [];
  final List<String> suitList = ['spade', 'heart', 'club', 'diamond'];
  final List<String> rankList = [
    "A",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "J",
    "Q",
    "K"
  ];

  int get length => deck.length;

// intial create a deck
  Deck() {
    for (final suit in suitList) {
      for (final rank in rankList) {
        deck.add(MyCard(suit: suit, rank: rank));
      }
    }
  }

  // shuffle
  void shuffle() {
    deck.shuffle();
  }

  // drawing 2 cards in first round
  List<MyCard> drawTwoCard() {
    List<MyCard> drawnCard = deck.sublist(0, 2);
    deck.removeRange(0, 2);
    return drawnCard;
  }

  // drawing 1 card in later round
  MyCard drawCard() {
    if (deck.isEmpty) {
      throw Exception('The deck is empty !');
    }
    MyCard drawnCard = deck.removeAt(0);
    return drawnCard;
  }
}
