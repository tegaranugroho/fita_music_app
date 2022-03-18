import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fita_music_app/data/datasource/music_remote_datasource.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/repositories/music_repository.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remoteDataSource;

  MusicRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Music>>> getMusicList() async {
    try {
      final result = await remoteDataSource.getMusicList();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Music>>> searchMusic(String query) async{
    try {
      final result = await remoteDataSource.searchMusic(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
