import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/mainPageUI.dart';
import 'package:flutter_blackjack/model/musicPlayer.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/settingPage.dart';

// shift to the main page

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Musicplayer musicplayer = new Musicplayer();

  @override
  void initState() {
    super.initState();
    musicplayer.playAudio('music/mainPage.mp3');
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mainPage/mainPage.gif"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                  ),
                  userIcon(100.0, 100.0),
                  Column(children: [
                    userInfo(),
                    Container(
                        color: const Color.fromARGB(104, 158, 158, 158),
                        child: Row(children: [
                          SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.email_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    musicplayer.stopAudio();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BattlePage()),
                                    );
                                    //
                                  })),
                          SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    musicplayer.stopAudio();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BattlePage()),
                                    );
                                    //
                                  })),
                          SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    musicplayer.stopAudio();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BattlePage()),
                                    );
                                    //
                                  })),
                          SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    musicplayer.stopAudio();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BattlePage()),
                                    );
                                    //
                                  }))
                        ])),
                  ])
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            musicplayer.stopAudio();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QuickGamePage()));
                          },
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/mainPage/quickGame.png"),
                                      fit: BoxFit.cover)),
                            ),
                            mainPagePanel(138.0, 13.0, 'Quick Game')
                          ]),
                        )),
                    Padding(padding: EdgeInsets.all(2)),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 6,
                                child: InkWell(
                                  onTap: () {
                                    musicplayer.stopAudio();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BattlePage()));
                                  },
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/img/mainPage/battle.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    mainPagePanel(136.0, 50.0, 'Battle')
                                  ]),
                                ))
                          ],
                        )),
                    Expanded(flex: 1, child: Container()),
                  ],
                )),
            Expanded(flex: 4, child: Container())
          ],
        ),
      ),
    );
  }
}
