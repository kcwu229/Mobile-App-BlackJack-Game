import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_blackjack/main.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FlickManager flickManager;
  VideoPlayerController videoPlayer =
      VideoPlayerController.asset('assets/videos/brandName.mp4');

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: videoPlayer,
        onVideoEnd: () {
          toMainPage();
        });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void toMainPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: FlickVideoWithControls(
            // remove the Controls panels
            controls: Container(),
          ),
        ),
      ),
    );
  }
}
