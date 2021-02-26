import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Song {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> songsList;
  int currentSongIndex;
  bool loopEnabled;

  Song() {
    this.currentSongIndex = -1;
    loopEnabled = false;
  }

  SongInfo getCurrentSong() {
    return 0 <= this.currentSongIndex ? this.songsList[currentSongIndex] : null;
  }

  bool playerIsPlaying() {
    return AudioPlayerState.PLAYING == audioPlayer.state;
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
    if (await Permission.storage.request().isGranted) {
      FlutterAudioQuery audioQuery = FlutterAudioQuery();
      return await audioQuery.getSongs();
    }

    return await Future.value(List<SongInfo>());
  }

  Future<int> playSong(int songIndex) async{
    this.currentSongIndex = songIndex;

    return await audioPlayer.play(songsList[songIndex].filePath);
  }

  Future<int> pauseSong() async {
    return await audioPlayer.pause();
  }

  Future<int> resumeSong() async{
    return await audioPlayer.resume();
  }

  Future<int> resumeOrPauseSong() async{
    if (AudioPlayerState.PLAYING == audioPlayer.state)
      return pauseSong();

    return resumeSong();
  }

  Future<int> nextSong() async{
    ++currentSongIndex;

    if (currentSongIndex >= songsList.length)
      currentSongIndex = 0;

    return playSong(currentSongIndex);
  }

  Future<int> repeatCurrentSong() async{
    return playSong(currentSongIndex);
  }

  Future<int> previousSong() async{
    --currentSongIndex;

    if (currentSongIndex < 0)
      currentSongIndex = songsList.length-1;

    return playSong(currentSongIndex);
  }

  Future<int> moveCurrentSongPosition(double position) async{
    int hours = (position / 3600).truncate();
    int minutes = (position / 60).truncate();
    int seconds = position.remainder(60).truncate();

    Duration newPosition = Duration(hours: hours, minutes: minutes, seconds: seconds);
    return await audioPlayer.seek(newPosition);
  }

  void loopCurrentSong(){
    loopEnabled = !loopEnabled;
  }
}