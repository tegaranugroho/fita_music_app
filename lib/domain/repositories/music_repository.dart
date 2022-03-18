import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/music.dart';

abstract class MusicRepository {
  Future<Either<Failure, List<Music>>> getMusicList();
  Future<Either<Failure, List<Music>>> searchMusic(String query);
}
