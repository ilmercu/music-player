import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

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
  
  @override
  void initState() {
    super.initState();
    song = Song();

    song.audioPlayer.onPlayerCompletion.listen((event) {
      song.nextSong();

      setState(() { });
    });
  }

  Future<void> playSong(int songIndex) async{
    await song.playSong(songIndex);
    setState(() { });
  }
  
  Future<void> pauseSong() async{
    await song.pauseSong();

    setState(() { });
  }

  Future<void> resumeSong() async {
    await song.resumeSong();
    setState(() {});
  }

  Future<void> resumeOrPauseSong() async {
    await song.resumeOrPauseSong();
    setState(() {});
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
                      pauseSong: pauseSong),
                  SongControls(
                      songInfo: song.getCurrentSong(),
                      audioPlayerState: song.getStateSong(),
                      resumeOrPauseSong: resumeOrPauseSong),
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
