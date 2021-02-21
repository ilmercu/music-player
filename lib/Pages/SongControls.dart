import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongControls extends StatefulWidget {
  SongControls(
      {Key key,
      this.currentSong,
      this.audioPlayerState,
      this.currentSongPosition,
      this.currentSongDuration,
      this.resumeOrPauseSong,
      this.moveCurrentSongPosition})
      : super(key: key);

  final SongInfo currentSong;
  final AudioPlayerState audioPlayerState;
  final Duration currentSongPosition;
  final Duration currentSongDuration;

  final moveCurrentSongPosition;
  final resumeOrPauseSong;

  @override
  _SongControlsState createState() => _SongControlsState();
}

class _SongControlsState extends State<SongControls> {
  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    SongInfo currentSong = widget.currentSong;
    if (null == currentSong ||
        null == widget.currentSongPosition ||
        null == widget.currentSongDuration) return Container();

    double deviceWidth = MediaQuery.of(context).size.width;

    IconData icon = Icons.play_arrow;

    if (AudioPlayerState.PLAYING == widget.audioPlayerState) icon = Icons.pause;

    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(left: 18.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      currentSong.title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      currentSong.artist,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    printDuration(widget.currentSongPosition),
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 1.0,
                      thumbColor: Colors.blue,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6)
                  ),
                  child: Slider(
                    value: widget.currentSongPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: widget.currentSongDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      widget.moveCurrentSongPosition(value);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 18.0),
                  child: Text(
                    printDuration(widget.currentSongDuration),
                  ),
                ),
              ],
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
