import 'package:fita_music_app/common/state_enum.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/usecase/search_music.dart';
import 'package:flutter/foundation.dart';

class MusicSearchNotifier extends ChangeNotifier {
  final SearchMusic searchMusic;

  MusicSearchNotifier({required this.searchMusic});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Music> _searchResult = [];
  List<Music> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> resetSearch() async {
    _searchResult = [];
    notifyListeners();
  }

  Future<void> fetchMusicSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMusic.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
