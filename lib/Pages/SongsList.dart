import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:swipeable/swipeable.dart';

class SongsList extends StatefulWidget {
  SongsList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  Future<List<SongInfo>> _songs;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  @override
  void initState() {
    super.initState();
    initSongsList();
  }

  void requestPermission() async{
    var status = await Permission.storage.status;
    if (status.isUndetermined)
      await Permission.storage.request();
  }

  void initSongsList() async{
    requestPermission();
    Future<List<SongInfo>> songsList = getSongs();

    setState(() {
      _songs = songsList;
    });
  }

  Future<List<SongInfo>> getSongs() async{
    await Future.delayed(const Duration(seconds: 2));

    if (await Permission.storage.request().isGranted)
      return await audioQuery.getSongs();

    return Future.value(List<SongInfo>());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongInfo>>(
      future: _songs,
      builder: (BuildContext context, AsyncSnapshot<List<SongInfo>> snapshot){
        if (snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              final item = snapshot.data[index];

              return Container(
                child: Swipeable(
                  threshold: 60.0,
                  onSwipeLeft: () {
                  },
                  onSwipeRight: () {
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
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                item.artist,
                                style: TextStyle(fontSize: 15),
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
                            Icons.stop,
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
      }
    );
  }
}
