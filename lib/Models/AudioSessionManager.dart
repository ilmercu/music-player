import 'package:audio_session/audio_session.dart';

import 'Song.dart';

class AudioSessionManager{
  AudioSession audioSession;
  Song song;

  AudioSessionManager(Song song){
    initAudioSession();
    this.song = song;
  }

  Future<void> initAudioSession() async{
    audioSession = await AudioSession.instance;
    await audioSession.configure(AudioSessionConfiguration.music());
    handleInterruptions();
  }

  void handleInterruptions() {
    audioSession.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            //Another app started playing audio and we should duck
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            //Another app started playing audio and we should pause
            song.pauseSong();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            //The interruption ended and we should unduck
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            //The interruption ended and we should resume
            song.resumeSong();
            break;
        }
      }
    });
  }

  Future<bool> setActive([bool newState]) async{
    bool state = null == newState ? !song.playerIsPlaying() : newState;
    return await audioSession.setActive(state);
  }
}