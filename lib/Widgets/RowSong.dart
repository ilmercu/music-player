import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongRow extends StatelessWidget {
  const SongRow({
    Key key,
    @required this.item,
    @required this.isPlaying,
  }) : super(key: key);

  final SongInfo item;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.white),
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
          Flexible(
            child: Container(
              height: 60.0,
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal
                    ),
                  ),
                  Text(
                    item.artist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
