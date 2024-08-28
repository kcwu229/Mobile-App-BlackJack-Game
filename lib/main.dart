import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blackjack/model/musicPlayer.dart';
import 'package:flutter_blackjack/pages/resultPage.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';
import 'package:flutter_blackjack/pages/quickGamePage.dart';
import 'package:flutter_blackjack/pages/splashScreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Splash Screen',
    home: SplashScreen(),
    routes: {
      '/home': (context) => MyHomePage(),
      '/second-screen': (context) => SecondScreen(),
      '/result-screen': (context) => ResultPage(),
    },
    onGenerateRoute: (settings) {
      // Check if the route is '/second-screen'
      if (settings.name == '/second-screen') {
        return MaterialPageRoute(
          builder: (context) => SecondScreen(),
        );
      } else if (settings.name == '/result-screen') {
        return MaterialPageRoute(builder: (context) => ResultPage());
      }
      return null;
    },
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  final musicplayer = new Musicplayer();

  @override
  void initState() {
    super.initState();
    musicplayer.playAudio('music/myHomePage.mp3');
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      // add a restriction on preventing the user the swipe finger to redirect to another page
      body: PopScope(
          canPop: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img/loginPage/login_1.jpg"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: <Widget>[
                // row 1, takes height 70%
                Expanded(flex: 7, child: Container()),

                // row 2, takes height 20%
                Expanded(
                    flex: 2,
                    child: Container(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromRGBO(83, 102, 94, 50),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      onPressed: () {
                        musicplayer.stopAudio();

                        // Navigate to the new page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPageWidget()),
                        );
                      },
                      child: DefaultTextStyle(
                          style: TextStyle(
                            // on scale
                            fontSize: height / 14,
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [FadeAnimatedText('Start Game')],
                            repeatForever: true,
                          )),
                    ))),
                // row 3, takes height 10%
                Expanded(flex: 1, child: Container())
              ],
            ),
          )),
    );
  }
}
