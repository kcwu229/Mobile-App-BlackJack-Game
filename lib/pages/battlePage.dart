import 'package:flutter/material.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

class BattlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
              child: RawMaterialButton(
        shape: CircleBorder(),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/homePage.png'))),
        ),
        onPressed: () {
          // Navigate to the new page
          //zzzzzzzz
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPageWidget()),
          );
        },
      ))),
    );
  }
}
