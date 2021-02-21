import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:simpleMusicPlayer/Widgets/RowSong.dart';
import 'package:swipeable/swipeable.dart';

class SongsList extends StatelessWidget {
  SongsList(
      {Key key,
      this.songsList,
      this.currentSongIndex,
      this.playSong,
      this.pauseSong})
      : super(key: key);
  final List<SongInfo> songsList;
  final int currentSongIndex;

  final playSong;
  final pauseSong;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: currentSongIndex >= 0
          ? EdgeInsets.only(bottom: 120.0)
          : EdgeInsets.zero,
      itemCount: songsList.length,
      itemBuilder: (context, index) {
        final item = songsList[index];

        return Swipeable(
          threshold: 60.0,
          onSwipeLeft: () {
            pauseSong();
          },
          onSwipeRight: () {
            playSong(index);
          },
          child: SongRow(
            item: item,
            isPlaying: currentSongIndex == index,
          ),
          background: Container(
            padding: EdgeInsets.all(8.0),
            height: 60.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: Colors.grey[300]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.pause,
                    color: Colors.black,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
