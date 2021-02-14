import 'package:flutter/material.dart';
import '../Pages/SongsList.dart';
import '../Pages/SongControls.dart';

import 'package:flutter_audio_query/flutter_audio_query.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SongInfo currentSong;

  void updateCurrentSong(SongInfo song){
    setState(() {
      currentSong = song;
    });
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
            SongsList(updateCurrentSong: updateCurrentSong),
            SongControls(currentSong: currentSong),
          ],
        ),
      ),
    );
  }
}
