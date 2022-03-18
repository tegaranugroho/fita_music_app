import 'package:fita_music_app/common/state_enum.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/usecase/get_music_list.dart';
import 'package:flutter/foundation.dart';

class MusicListNotifier extends ChangeNotifier {
  final GetMusicList getMusicList;

  MusicListNotifier({required this.getMusicList});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Music> _musicList = [];
  List<Music> get musicList => _musicList;

  String _message = '';
  String get message => _message;


  Future<void> fetchMusicList() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getMusicList.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (musicListData) {
        _musicList = musicListData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
