import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Song {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> songsList;
  int currentSongIndex;

  Song() {
    this.currentSongIndex = -1;
  }

  SongInfo getCurrentSong() {
    return 0 <= this.currentSongIndex ? this.songsList[currentSongIndex] : null;
  }

  AudioPlayerState getStateSong() {
    return audioPlayer.state;
  }

  void setSongList(List<SongInfo> songList) {
    this.songsList = songList;
  }

  static Future<List<SongInfo>> initSongsList() async {
    await requestPermission();
    return getSongs();
  }

  static Future<void> requestPermission() async {
    var status = await Permission.storage.status;

    if (status.isUndetermined) await Permission.storage.request();
  }

  static Future<List<SongInfo>> getSongs() async {
    //await Future.delayed(const Duration(seconds: 2));

    if (await Permission.storage.request().isGranted) {
      FlutterAudioQuery audioQuery = FlutterAudioQuery();
      return await audioQuery.getSongs();
    }

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
    ++currentSongIndex;

    if (currentSongIndex > songsList.length)
      currentSongIndex = 0;

    playSong(currentSongIndex);
  }
}