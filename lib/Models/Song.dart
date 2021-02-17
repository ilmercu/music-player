import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';

class Song{
  static FlutterAudioQuery audioQuery = FlutterAudioQuery();
  static AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> songsList;
  int currentSongIndex;

  Song(List<SongInfo> songsList) {
    this.songsList = songsList;
    this.currentSongIndex = -1;
    
    audioPlayer.onPlayerCompletion.listen((event) {
      print ("traccia finita, stato del player " + audioPlayer.state.toString());
    });
  }

  SongInfo getCurrentSong(){
    return 0 <= this.currentSongIndex ? this.songsList[currentSongIndex] : null; 
  }

  static Future<List<SongInfo>> initSongsList() async{
    await requestPermission();
    return getSongs();
  }

  static Future<void> requestPermission() async{
    var status = await Permission.storage.status;
    
    if (status.isUndetermined)
      await Permission.storage.request();
  }

  static Future<List<SongInfo>> getSongs() async{
    //await Future.delayed(const Duration(seconds: 2));

    if (await Permission.storage.request().isGranted)
      return await audioQuery.getSongs();

    return await Future.value(List<SongInfo>());
  }

  Future<int> playSong(int songIndex) async{
    //audioPlayer.state = AudioPlayerState.PLAYING;
    this.currentSongIndex = songIndex;

    return await audioPlayer.play(songsList[songIndex].filePath);
  }

  Future<int> pauseSong() async {
    //audioPlayer.state = AudioPlayerState.PAUSED;
    return await audioPlayer.pause();
  }

  Future<int> resumeSong() async{
    //audioPlayer.state = AudioPlayerState.PLAYING;
    return await audioPlayer.resume();
  }

  Future<int> resumeOrPauseSong() async{
    if (AudioPlayerState.PLAYING == audioPlayer.state)
      return pauseSong();

    return resumeSong();
  }

  void nextSong(){
    /*print (this.currentSong.id);
    print ()*/
  }
}