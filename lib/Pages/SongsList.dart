import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:swipeable/swipeable.dart';

class SongsList extends StatefulWidget {
  SongsList({Key key, this.songsList, this.currentSongIndex, this.playSong, this.pauseSong}) : super(key: key);

  final List<SongInfo> songsList;
  final int currentSongIndex;

  final playSong;
  final pauseSong;

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.currentSongIndex >= 0 ? EdgeInsets.only(bottom: 120.0) : EdgeInsets.zero,
      itemCount: widget.songsList.length,
      itemBuilder: (context, index){
        final item = widget.songsList[index];

        return Container(
          child: Swipeable(
            threshold: 60.0,
            onSwipeLeft: () {
              widget.pauseSong();
            },
            onSwipeRight: () {
              widget.playSong(index);
            },
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: Colors.white
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    height: 60.0,
                    child: Icon(
                      Icons.audiotrack,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: index == widget.currentSongIndex ? FontWeight.bold : FontWeight.normal
                          ),
                        ),
                        Text(
                          item.artist,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            background: Container(
              padding: EdgeInsets.all(8.0),
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: Colors.grey[300]
              ),
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
          ),
        );
      },
    );
  }
}
