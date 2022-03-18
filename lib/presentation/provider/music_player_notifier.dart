import 'package:audio_manager/audio_manager.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:flutter/foundation.dart';

class MusicPlayerNotifier extends ChangeNotifier {
  final _audioManagerInstance = AudioManager.instance;


  bool _showPlayer = false;
  bool get showPlayer => _showPlayer;

  bool _isEnded = true;
  bool get isEnded => _isEnded;

  Music _selected = Music();
  Music get selected => _selected;

  Future<void> play({required Music music}) async {
    _showPlayer = true;
    _isEnded = false;
    _selected = music;
    notifyListeners();

    await _audioManagerInstance.start(
      music.previewUrl ?? '',
      music.trackName ?? '',
      desc: music.shortDescription ?? '',
      cover: music.artworkUrl100 ?? '',
    );
  }

  Future<void> log() async {
    _audioManagerInstance.onEvents((events, args) {
      if (events == AudioManagerEvents.ended ||
          events == AudioManagerEvents.error ||
          events == AudioManagerEvents.stop) {
        _isEnded = true;
        notifyListeners();
      } else if (events == AudioManagerEvents.ready) {
        _isEnded = false;
        notifyListeners();
      }
    });
  }

  Future<void> playOrPause() async {
    _isEnded = !_isEnded;
    notifyListeners();
    await _audioManagerInstance.playOrPause();
  }
}
