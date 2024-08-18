import 'package:audioplayers/audioplayers.dart';

class Musicplayer {
  final _audioPlayer = AudioPlayer();
  bool stop = false;

  Future<void> _loadAndPlayAudio(fileName) async {
    Source audioFile = AssetSource(fileName);
    await _audioPlayer.setSource(audioFile);
    if (stop == false) {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(audioFile);
    }
  }

  Future<void> playAudio(String fileName) async {
    await _loadAndPlayAudio(fileName);
  }

  Future<void> stopAudio() async {
    stop = true;
    await _audioPlayer.stop();
  }
}
