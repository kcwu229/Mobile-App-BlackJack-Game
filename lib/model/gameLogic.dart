import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart' as blackjack_card;
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/player.dart';

class InitalGameState {
  // flag for win / lose -- default no
  bool gameOver = false;
  String result = '';

  Deck deck = Deck();

  List<Player> players = [];

  InitalGameState() {
    // initial Create Player
    players = [
      Player('dealer', false),
      Player('cpu1', false),
      Player('player', true),
      Player('cpu2', false)
    ];

    // shuffle the card for drawing
    deck.shuffle();

    // Round 1
    for (var player in players) {
      player.inHand.addAll(deck.drawTwoCard());
      player.score = calculation(player.inHand, player.score, player);
    }

    // Round 2 -- not finish yet
    nextRound() {
      for (var player in players) {
        if (player.bust != true || player.stand != true) {
          player.actionEnded = false;
        }
        if (player.isPlayer != true) {
          if (player.score < 15) {
            drawCard(player.inHand, deck, player.score, player);
          } else if (player.isPlayer == true) {
            Future<void> playerRound(Player player) async {
              print("Player's turn: ${player.name}");
              print("Current score: ${player.score}");

              bool? action;
              do {
                ///
              } while (player.actionEnded = false);

              if (action == 'hit') {
                //
              } else if (action == 'stand') {
                //
              }
            }
          }
        }
      }
    }
  }

  void drawCard(List<MyCard> cards, Deck deck, int score, Player player) {
    if (deck.length < 1) {
      throw Exception('The deck is empty !');
    }
    // call function from deck instance
    MyCard drawnCard = deck.drawCard();
    cards.add(drawnCard);
    player.score = calculation(cards, score, player);
  }

  Player getPlayer(String name) {
    return players.firstWhere((p) => p.name == name,
        orElse: () => throw Exception('No such player !!!'));
  }

// apply on cpu and dealer only
  void hit(Player player) {
    player ??= Player('', false);
    player.inHand.add(deck.drawCard() as MyCard);
  }

  void stand(Player player) {
    player.actionEnded = true;
  }

  // stopped here
  void endRound(bool bust, bool stand, bool naturalBlackJack) {
    // Priority 1: If card in hand is 2 & (Ace + 10 / J / Q / K)
    // Priority 2: All stand and got winner
    // Priority 3: All bust and no winner
  }

  // Need to calculate in every time as value of Ace depends on the card it owns...
  int calculation(List<MyCard> cards, score, Player player) {
    score = 0;

    int countAce(List<MyCard> hand) {
      return hand.where((card) => card.rank == 'A').length;
    }

    for (var card in cards) {
      // 1: JQK -> 10 marks
      if (['J', 'Q', 'K'].contains(card.rank)) {
        score += 10;
      }

      // 2: 2 - 10
      else if (card.rank != 'A') {
        score += int.parse(card.rank);
      }

      // What if there are 1 Ace in Hand, and
      else if ((countAce(cards) == 1) & (card.rank == 'A')) {
        if (score < 11) {
          score += 11;
        } else {
          score += 1;
        }
      }

      // What if there are multi-Ace in Hand,
      else if ((countAce(cards) > 1) & (card.rank == 'A')) {
        if (score < 11) {
          score += 11;
        } else {
          score += 1;
        }
      }
    }
    return score;
  }

  playerEndTurn(Player player) {
    player.actionEnded = true;
  }

  //
}
