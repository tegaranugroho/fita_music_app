import 'package:dartz/dartz.dart';
import 'package:fita_music_app/domain/repositories/music_repository.dart';

import '../../common/failure.dart';
import '../entities/music.dart';

class GetMusicList {
  final MusicRepository repository;

  GetMusicList(this.repository);

  Future<Either<Failure, List<Music>>> execute() {
    return repository.getMusicList();
  }
}
