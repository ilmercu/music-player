import 'package:flutter/material.dart';
import '../Pages/SongsList.dart';
import '../Pages/SongControls.dart';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SongInfo currentSong;
  AudioPlayer audioPlayer = AudioPlayer();

  void playSong(SongInfo song){
    setState(() {
      currentSong = song;
      audioPlayer.state = AudioPlayerState.PLAYING;
    });

    audioPlayer.play(currentSong.filePath);
  }
  
  void pauseSong(){
    setState(() {
      audioPlayer.state = AudioPlayerState.PAUSED;
    });

    audioPlayer.pause();
  }

  void resumeSong(){
    setState(() {
      audioPlayer.state = AudioPlayerState.PLAYING;
    });

    audioPlayer.resume();
  }

  void playOrPauseSong(){
    if (AudioPlayerState.PLAYING == audioPlayer.state)
      pauseSong();
    else if (AudioPlayerState.PAUSED == audioPlayer.state)
      resumeSong();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            SongsList(playSong: playSong, pauseSong: pauseSong),
            SongControls(currentSong: currentSong, audioPlayerState: audioPlayer.state, playOrPauseSong: playOrPauseSong),
          ],
        ),
      ),
    );
  }
}
