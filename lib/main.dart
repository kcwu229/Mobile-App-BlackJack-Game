import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 强制横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        // Navigate to the new page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      child: Text(
                        '開始遊戲',
                        style: TextStyle(fontSize: 45),
                      )),
                )),

            // row 3, takes height 10%
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    );
  }
}
