import 'package:dartz/dartz.dart';
import 'package:fita_music_app/common/failure.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/repositories/music_repository.dart';


class SearchMusic {
  final MusicRepository repository;

  SearchMusic(this.repository);

  Future<Either<Failure, List<Music>>> execute(String query) {
    return repository.searchMusic(query);
  }
}
