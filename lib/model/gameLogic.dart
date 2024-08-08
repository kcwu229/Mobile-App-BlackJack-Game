import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:collection';
import 'dart:math';

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

    //
    //initalBetPage

    // Round 1
    for (var player in players) {
      player.inHand.addAll(deck.drawTwoCard());
      player.score =
          calculation(player.inHand, player, countAce(player.inHand));
      settle(player.inHand, players, player);
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

  int countWon(List<Player> players) {
    return players.where((player) => player.hasWon).length;
  }

  Player getPlayer(String name) {
    return players.firstWhere((p) => p.name == name,
        orElse: () => throw Exception('No such player !!!'));
  }

  int countAce(List<MyCard> hand) {
    return hand.where((card) => card.rank == 'A').length;
  }

// apply on cpu and dealer only
  void hit(Player player) {
    player.inHand.add(deck.drawCard());
    player.score = calculation(player.inHand, player, countAce(player.inHand));
    player.myTurn = false;
    print('${player.name} has draw the card !!!');
    settle(player.inHand, players, player);
    playerEndTurn(player);
  }

  void stand(Player player) {
    player.hasStand = true;
    player.myTurn = false;
    print('${player.name} -  stand !!!');
    playerEndTurn(player);
  }

  // Need to calculate in every time as value of Ace depends on the card it owns...
  int calculation(List<MyCard> cards, Player player, int countAce) {
    int totalScore = 0;
    int maxScoreNotBust = 0;

    for (var card in cards) {
      // 1: JQK -> 10 marks
      if (['J', 'Q', 'K'].contains(card.rank)) {
        totalScore += 10;
        print('${player.name}: -- this time the score is 10}');
      }

      // 2: 2 - 10
      else if (card.rank != 'A') {
        totalScore += int.parse(card.rank);
        print(
            '${player.name}: -- this time the score is ${int.parse(card.rank)}');
      } else {
        totalScore += 1;
      }
    }

    // For player who got Ace:
    maxScoreNotBust = 21 - totalScore;

    for (var i = 0; i < countAce; i++) {
      if (maxScoreNotBust >= 14 && countAce > 0) {
        print(
            '${player.name}: -- the remaining score not to bust is ${maxScoreNotBust}');

        totalScore += 10;
        print('${player.name}: -- chane the value of Ace from 1 to 11 !');
      }
    }

    print('${player.name}: -- total ${totalScore} !');
    return totalScore;
  }

  void playerEndTurn(Player player) {
    player.actionEnded = true;
    print('${player.name} has ended his action');
  }

  void settle(List<MyCard> cards, List<Player> players, Player player) {
    List<Player> survivor = [];

    // 1. If Neutral Happen -- winner - endRound
    if ((player.score == 21) && (cards.length == 2)) {
      player.gotNaturalBlackJack = true;
      player.hasWon = true;
      print('${player.name} gets neutral black jack, and win the game !');
    }

    // 2. If bust -- bool bust = true
    else if (player.score > 21) {
      player.isBust = true;
      print('${player.name},  unfortunately get busted and lose the game !');
    } else if ((countBust(players) + countStand(players)) < players.length) {
      if (player.hasStand && !player.isBust) {
        player.hasWon = true;
      } else if ((countBust(players) + countStand(players)) == players.length) {
        if (!player.isBust) {
          survivor.add(player);
        }
      }
    }

    print(survivor.length);
    // calculate the highestScore on the remaining player
    List<Player> playerWithMaxScore = survivor
        .where((player) =>
            player.score == survivor.map((p) => p.score).reduce(max))
        .toList();

    for (Player player in playerWithMaxScore) {
      player.hasWon = true;
      print('- ${player.name} (score: ${player.score})');
    }
  }
}
