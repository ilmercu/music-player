import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../Models/Song.dart';

class SongControls extends StatefulWidget {
  SongControls({Key key, this.song, this.audioPlayerState, this.resumeOrPauseSong}) : super(key: key);

  final Song song;
  final AudioPlayerState audioPlayerState;

  final resumeOrPauseSong;

  @override
  _SongControlsState createState() => _SongControlsState();
}

class _SongControlsState extends State<SongControls> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    IconData icon = Icons.play_arrow;

    if (AudioPlayerState.PLAYING == widget.audioPlayerState)
      icon = Icons.pause;

    print(widget.song.currentSongIndex);

    var currentSong = widget.song.getCurrentSong();

    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(left: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  null == currentSong ? '-' : currentSong.title,
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  null == currentSong ? '-' : currentSong.artist,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              height: 60.0,
              child: IconButton(
                icon: Icon(
                  icon,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () {
                  widget.resumeOrPauseSong();
                },
              ),
            ),
          ],
        ),
        width: deviceWidth,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
