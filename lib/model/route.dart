import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/myController.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/quickGamePage.dart';

// bind with Stateful Widget
Map<String, WidgetBuilder> routes = {
  '/': (context) => QuickGamePage(),
  '/second-screen': (context) => SecondScreen(
      controller: ModalRoute.of(context)!.settings.arguments as MyController)
};
