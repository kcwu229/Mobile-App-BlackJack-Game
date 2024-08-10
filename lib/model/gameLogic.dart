import 'dart:math';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/player.dart';

class InitalGameState {
  bool gameOver = false;
  String result = '';

  Deck deck = Deck();

  List<Player> players = [];
  List<Player> survivor = [];
  List<String> playerWonList = [];

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
      settle(players, player, countPlayerActionEnded);
    }
  }

  // newly added

  int countPlayerActionEnded() {
    int total = countWon(players) + countStand(players) + countBust(players);
    print('Total: --  ${total}');
    return total;
  }

  void handlePlayerAction(String string) {
    // Implementation of the function
    print(string);
  }

  int countBust(List<Player> players) {
    return players.where((player) => player.isBust == true).length;
  }

  int countStand(List<Player> players) {
    return players.where((player) => player.hasStand == true).length;
  }

  int countWon(List<Player> players) {
    return players.where((player) => player.hasWon == true).length;
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
    print('${player.name}: has busted ? ${player.isBust}');
    print('${player.name}: has stand ? ${player.hasStand}');
    print('${player.name}: has won ? ${player.hasWon}');
    settle(players, player, countPlayerActionEnded);
    playerEndTurn(player);
  }

  void stand(Player player) {
    player.hasStand = true;
    player.myTurn = false;
    print('${player.name} -  stand !!!');
    print('${player.name}: has busted ? ${player.isBust}');
    print('${player.name}: has stand ? ${player.hasStand}');
    print('${player.name}: has won ? ${player.hasWon}');

    settle(players, player, countPlayerActionEnded);
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

  void settle(List<Player> players, Player player, countPlayerActionEnded()) {
    // 1. If Neutral Happen -- winner - endRound
    markNeutralBlackJack(player, gameOver);
    markBust(player);
    markStand(player, survivor);

    print('Now, number of survivor in :${survivor.length}');

// if winner exist
    chooseWinner(playerWonList, players, survivor);
  }

  void markNeutralBlackJack(Player player, bool gameOver) {
    if ((player.score == 21)) {
      if (player.inHand.length == 2) {
        player.gotNaturalBlackJack = true;
        print('${player.name} gets neutral black jack !');
      }
      player.hasWon = true;
      gameOver = true;
      print('${player.name} win the game !');
    }
  }

  void markBust(Player player) {
    if (player.score > 21) {
      player.isBust = true;
      print('${player.name},  unfortunately get busted and lose the game !');
    }
  }

  void markStand(Player player, List<Player> survivorList) {
    if ((player.hasWon == false) &&
        (player.hasStand == true) &&
        (player.isBust == false)) {
      print('${player.name} --  stand ? -- ${player.hasStand}');
      survivorList.add(player);
    }
  }

  void chooseWinner(
      List<String> playerWonList, List<Player> players, List<Player> survivor) {
    playerWonList = players
        .where((player) => player.hasWon == true)
        .map((player) => player.name)
        .toList();

    if ((playerWonList.length == 0) &&
        (countPlayerActionEnded() == players.length)) {
      print('Why I cannot fix this !!!!');
      List<Player> playerWithMaxScore = survivor
          .where((player) =>
              player.score == survivor.map((p) => p.score).reduce(max))
          .toList();

      for (Player player in playerWithMaxScore) {
        player.hasWon = true;
        print('- ${player.name} (score: ${player.score})');
        gameOver = true;
      }
    }

    if (playerWonList.length > 0) {
      print('The following winner won the game: ${playerWonList}');
      gameOver = true;
    }
    ;
  }
}
