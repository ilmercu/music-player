import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongControls extends StatefulWidget {
  SongControls({Key key, this.title, this.currentSong}) : super(key: key);

  final String title;
  final SongInfo currentSong;

  @override
  _SongControlsState createState() => _SongControlsState();
}

class _SongControlsState extends State<SongControls> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              null != widget.currentSong ? widget.currentSong.title : '-',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              null != widget.currentSong ? widget.currentSong.artist : '-',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        width: deviceWidth,
        height: 120.0,
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
