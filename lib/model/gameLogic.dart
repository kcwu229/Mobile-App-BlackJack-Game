import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart' as blackjack_card;
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/userIcon.dart';

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
      player.score = calculation(player.inHand, player);
      settle(player);
    }
  }

  // newly added
  void handlePlayerAction(String string) {
    // Implementation of the function
    print(string);
  }

  int countBust(List<Player> players) {
    return players.where((player) => player.isBust).length;
  }

  int countStand(List<Player> players) {
    return players.where((player) => player.hasStand).length;
  }

  Player getPlayer(String name) {
    return players.firstWhere((p) => p.name == name,
        orElse: () => throw Exception('No such player !!!'));
  }

// apply on cpu and dealer only
  void hit(Player player) {
    player.inHand.add(deck.drawCard());
    player.score = calculation(player.inHand, player);
    player.myTurn = false;
    print('${player.name} has draw the card !!!');
    settle(player);
    playerEndTurn(player);
  }

  void stand(Player player) {
    player.hasStand = true;
    player.myTurn = false;
    print('${player.name} -  stand !!!');
    playerEndTurn(player);
  }

  // Need to calculate in every time as value of Ace depends on the card it owns...
  int calculation(List<MyCard> cards, Player player) {
    int score = 0;

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

  void playerEndTurn(Player player) {
    player.actionEnded = true;
    print('${player.name} has ended his action');
  }

  void settle(Player player) {
    // 1. If Neutral Happen -- winner - endRound
    if ((player.score == 21) && (player.inHand.length == 2)) {
      player.gotNaturalBlackJack = true;
      player.hasWon = true;
      print('${player.name} gets neutral black jack, and win the game !');
    }

    // 2. If bust -- bool bust = true
    else if (player.score > 21) {
      player.isBust = true;
      print('${player.name},  unfortunately get busted and lose the game !');
    }
  }
  //
}
