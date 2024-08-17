import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.asset('assets/videos/brandName.mp4'),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  // TO DO: add the push page to HomePage after the video is finished.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
      alignment: Alignment.center,
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          controls: Container(),
        ),
      ),
    ));
  }
}
