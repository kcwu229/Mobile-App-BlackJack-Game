import 'package:flutter/material.dart';
import 'package:flutter_blackjack/pages/quickPage.dart';

// shift to the main page
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mainPage/main_1.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  Expanded(flex: 6, child: Container()),
                  Expanded(
                      flex: 4,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 9,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/img/mainPage/startGame.jpg"),
                                        fit: BoxFit.cover)),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Color.fromRGBO(53, 53, 52, 0.878),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "快速挑戰",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
                      )),
                  Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(right: 18),
                      )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 4,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        color:
                                            Color.fromRGBO(78, 82, 136, 0.898),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('設定',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/img/mainPage/setting.jpg'))),
                                      ))
                                ],
                              )),
                          Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 18),
                              )),
                          Expanded(
                              flex: 5,
                              child: Row(children: <Widget>[
                                Expanded(
                                    flex: 8,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/img/mainPage/change_1.jpg'),
                                              fit: BoxFit.cover)),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      color:
                                          Color.fromRGBO(98, 100, 103, 0.753),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '變裝',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                              ])),
                        ],
                      )),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the new page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuickGamePage()),
          );
        },
        tooltip: 'Set the flag to enter the main page',
        child: const Icon(Icons.add),
      ),
    );
  }
}
