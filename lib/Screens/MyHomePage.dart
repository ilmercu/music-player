import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:simpleMusicPlayer/Models/AudioSessionManager.dart';

import '../Models/Song.dart';
import '../Pages/SongControls.dart';
import '../Pages/SongsList.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Song song;
  Duration currentSongPosition;
  Duration currentSongDuration;
  AudioSessionManager audioSessionManager;

  @override
  void initState() {
    super.initState();

    song = Song();
    
    song.audioPlayer.onAudioPositionChanged.listen((Duration position) {
      if (position <= currentSongDuration){
        setState(() {
          currentSongPosition = position;
        });
      }
    });
    
    song.audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        currentSongDuration = duration;
      });
    });

    song.audioPlayer.onPlayerCompletion.listen((event) {
      song.nextSong();

      setState(() { });
    });
    
    audioSessionManager = AudioSessionManager(song);
  }

  Future<void> playSong(int songIndex) async{
    if (await audioSessionManager.setActive(true)) {
      await song.playSong(songIndex);
      setState(() { });
    }
  }
  
  Future<void> pauseSong() async{
    if (await audioSessionManager.setActive(false)){
      await song.pauseSong();
      setState(() { });
    }
  }

  Future<void> resumeSong() async {
    if (await audioSessionManager.setActive(true)) {
      await song.resumeSong();
      setState(() {});
    }
  }

  Future<void> resumeOrPauseSong() async {
    if (await audioSessionManager.setActive()) {
      await song.resumeOrPauseSong();
      setState(() {});
    }
  }

  Future<void> moveCurrentSongPosition(double position) async{
    await song.moveCurrentSongPosition(position);
    setState(() { });
  }

  Future<void> nextSong() async{
    await song.nextSong();
    setState(() { });
  }

  Future<void> previousSong() async{
    await song.previousSong();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<SongInfo>>(
          future: Song.getSongs(),
          builder: (BuildContext context, AsyncSnapshot<List<SongInfo>> snapshot){
            if (snapshot.hasData){
              song.setSongList(snapshot.data);
              return Stack(
                children: <Widget>[
                  SongsList(
                    songsList: song.songsList,
                    currentSongIndex: song.currentSongIndex,
                    playSong: playSong,
                    pauseSong: pauseSong
                  ),
                  SongControls(
                    currentSong: song.getCurrentSong(),
                    playerIsPlaying: song.playerIsPlaying(),
                    currentSongPosition: currentSongPosition,
                    currentSongDuration: currentSongDuration,
                    resumeOrPauseSong: resumeOrPauseSong,
                    moveCurrentSongPosition: moveCurrentSongPosition,
                    previousSong: previousSong,
                    nextSong: nextSong
                  ),
                ],
              );
            }
            else if (snapshot.hasError){
              return Center(
                child: SizedBox(
                  child: Text('Error retrieving songs.'),
                  width: 60,
                  height: 60,
                ),
              );
            }
          
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            );
          },
        ),
      ),
    );
  }
}
