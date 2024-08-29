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
  List<String> winnerNameList = [];
  List<Player> winnerList = [];

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
      settle(players, player, countPlayerActionEnded);
    }
  }

  // newly added

  int countPlayerActionEnded() {
    int total = countWon(players) + countStand(players) + countBust(players);
    return total;
  }

  List<Player> getWinnerList(players) {
    return players.where((player) => player.hasWon == true).toList();
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
    var newCard = deck.drawCard();
    (player.isPlayer == false) ? newCard.showFace = false : '';
    print('Done');
    player.inHand.add(newCard);
    player.score =
        calculateScore(player.inHand, player, countAce(player.inHand));
    player.myTurn = false;
    settle(players, player, countPlayerActionEnded);
    playerEndTurn(player);
  }

  void stand(Player player) {
    player.hasStand = true;
    player.myTurn = false;
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

// if winner exist
    chooseWinner(winnerNameList, players, survivor);
  }

  void markNeutralBlackJack(Player player, bool gameOver) {
    if ((player.score == 21)) {
      if (player.inHand.length == 2) {
        player.gotNaturalBlackJack = true;
      }
      player.hasWon = true;
      gameOver = true;
    }
  }

  void markBust(Player player) {
    if (player.score > 21) {
      player.isBust = true;
    }
  }

  void markStand(Player player, List<Player> survivorList) {
    if ((player.hasWon == false) &&
        (player.hasStand == true) &&
        (player.isBust == false)) {
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
      List<Player> playerWithMaxScore = survivor
          .where((player) =>
              player.score == survivor.map((p) => p.score).reduce(max))
          .toList();

      for (Player player in playerWithMaxScore) {
        player.hasWon = true;
        gameOver = true;
      }
    }

    if (playerWonList.length > 0) {
      gameOver = true;
    }
    // obtain the
    winnerList = getWinnerList(players);
  }
}
