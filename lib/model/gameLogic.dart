import 'dart:math';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/player.dart';

class InitalGameState {
  bool gameOver = false;
  String result = '';

  Deck deck = Deck();

  List<Player> players = [];

  InitalGameState() {
    players = [
      Player('dealer', false),
      Player('cpu1', false),
      Player('player', true),
      Player('cpu2', false)
    ];

    deck.shuffle();

    // Round 1
    for (var player in players) {
      player.inHand.addAll(deck.drawTwoCard());
      player.score =
          calculateScore(player.inHand, player, countAce(player.inHand));
      print('Round 1:  ${player.name} - score: ${player.score}');
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
    player.score =
        calculateScore(player.inHand, player, countAce(player.inHand));
    player.myTurn = false;
    print('${player.name} has draw the card !!!');
    settle(player.inHand, players, player);
    playerEndTurn(player);
  }

  void stand(Player player) {
    player.hasStand = true;
    player.myTurn = false;
    print('${player.name} -  stand !!!');
    settle(player.inHand, players, player);
    playerEndTurn(player);
  }

  int calculateScore(List<MyCard> cards, Player player, int countAce) {
    int totalScore = 0;
    int remainingScore = 0;

    for (var card in cards) {
      if (['J', 'Q', 'K'].contains(card.rank)) {
        totalScore += 10;
      } else if (card.rank != 'A') {
        totalScore += int.parse(card.rank);
      } else {
        totalScore += 1;
      }
    }

    // For player who got Ace:
    remainingScore = 21 - totalScore;
    for (var i = 0; i < countAce; i++) {
      if (remainingScore >= 10) {
        totalScore += 10;
        remainingScore -= 10;
      }
    }
    print('${player.name} - total score is : ${totalScore}');
    print('${player.name} - remaining score is : ${remainingScore}');

    return totalScore;
  }

  void playerEndTurn(Player player) {
    player.actionEnded = true;
  }

  void settle(List<MyCard> cards, List<Player> players, Player player) {
    List<Player> survivor = [];

    // 1. If Neutral Happen -- winner - endRound
    if ((player.score == 21)) {
      if (cards.length == 2) {
        player.gotNaturalBlackJack = true;
        print('${player.name} gets neutral black jack !');
      }
      player.hasWon = true;
      //gameOver = true;
      print('${player.name} win the game !');
    }

    // 2. If bust -- bool bust = true
    else if (player.score > 21) {
      player.isBust = true;
      print('${player.name},  unfortunately get busted and lose the game !');
    }
    // 3. if all stand
    else if ((countBust(players) + countStand(players)) == players.length) {
      if (player.isBust == false) {
        survivor.add(player);
      }
    }

    List<Player> playerWithMaxScore = survivor
        .where((player) =>
            player.score == survivor.map((p) => p.score).reduce(max))
        .toList();

    print(survivor.length);

    List<String> playerWonList = players
        .where((player) => player.hasWon == true)
        .map((player) => player.name)
        .toList();

    for (Player player in playerWithMaxScore) {
      player.hasWon = true;
      print('- ${player.name} (score: ${player.score})');
    }
    //gameOver = true;

    print('The following winner won the game: ${playerWonList}');
  }
}
