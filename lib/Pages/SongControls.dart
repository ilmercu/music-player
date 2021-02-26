import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../Widgets/TrackShape.dart';

class SongControls extends StatefulWidget {
  SongControls(
      {Key key,
      this.currentSong,
      this.playerIsPlaying,
      this.currentSongPosition,
      this.currentSongDuration,
      this.resumeOrPauseSong,
      this.moveCurrentSongPosition,
      this.previousSong,
      this.nextSong})
      : super(key: key);

  final SongInfo currentSong;
  final bool playerIsPlaying;
  final Duration currentSongPosition;
  final Duration currentSongDuration;

  final moveCurrentSongPosition;
  final resumeOrPauseSong;
  final previousSong;
  final nextSong;

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

    IconData icon = widget.playerIsPlaying ? Icons.pause : Icons.play_arrow;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          printDuration(widget.currentSongPosition),
                        ),
                      ),
                      Container(
                        child: Text(
                          printDuration(widget.currentSongDuration),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      currentSong.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Text(
                      currentSong.artist,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.skip_previous,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        onPressed: () {
                          widget.previousSong();
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          icon,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        onPressed: () {
                          widget.resumeOrPauseSong();
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.black,
                          size: 40.0,
                        ),
                        onPressed: () {
                          widget.nextSong();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            width: deviceWidth,
            height: 140.0,
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
        ),
        Positioned(
          bottom: 0,
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth,
                padding: EdgeInsets.only(bottom: 116.0),
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 0.2,
                    thumbColor: Colors.blue,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                    trackShape: TrackShape(),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
