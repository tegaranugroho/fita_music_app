import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fita_music_app/common/exception.dart';
import 'package:fita_music_app/common/failure.dart';
import 'package:fita_music_app/data/model/music_model.dart';
import 'package:fita_music_app/data/repositories/music_repository_impl.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MusicRepositoryImpl repository;
  late MockMusicRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockMusicRemoteDataSource();
    repository = MusicRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });
  final tMusicModel = MusicModel(
    wrapperType: "track",
    kind: "song",
    artistId: 909253,
    collectionId: 1469577723,
    trackId: 1469577741,
    artistName: "Jack Johnson",
    collectionName:
        "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    collectionCensoredName:
        "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
    trackCensoredName: "Upside Down",
    artistViewUrl: "https://music.apple.com/us/artist/jack-johnson/909253?uo=4",
    collectionViewUrl:
        "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
    trackViewUrl:
        "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
    previewUrl:
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/5e/5b/3d/5e5b3df4-deb5-da78-5d64-fe51d8404d5c/mzaf_13341178261601361485.plus.aac.p.m4a",
    artworkUrl30:
        "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/30x30bb.jpg",
    artworkUrl60:
        "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
    artworkUrl100:
        "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/100x100bb.jpg",
    collectionPrice: 9.99,
    trackPrice: 1.29,
    releaseDate: "2005-01-01T12:00:00Z",
    collectionExplicitness: "notExplicit",
    trackExplicitness: "notExplicit",
    discCount: 1,
    discNumber: 1,
    trackCount: 14,
    trackNumber: 1,
    trackTimeMillis: 208643,
    country: "USA",
    currency: "USD",
    primaryGenreName: "Rock",
    isStreamable: true,
  );

  final tMusic = Music(
    wrapperType: "track",
    kind: "song",
    artistId: 909253,
    collectionId: 1469577723,
    trackId: 1469577741,
    artistName: "Jack Johnson",
    collectionName:
        "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    collectionCensoredName:
        "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
    trackCensoredName: "Upside Down",
    artistViewUrl: "https://music.apple.com/us/artist/jack-johnson/909253?uo=4",
    collectionViewUrl:
        "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
    trackViewUrl:
        "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
    previewUrl:
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/5e/5b/3d/5e5b3df4-deb5-da78-5d64-fe51d8404d5c/mzaf_13341178261601361485.plus.aac.p.m4a",
    artworkUrl30:
        "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/30x30bb.jpg",
    artworkUrl60:
        "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg",
    artworkUrl100:
        "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/100x100bb.jpg",
    collectionPrice: 9.99,
    trackPrice: 1.29,
    releaseDate: "2005-01-01T12:00:00Z",
    collectionExplicitness: "notExplicit",
    trackExplicitness: "notExplicit",
    discCount: 1,
    discNumber: 1,
    trackCount: 14,
    trackNumber: 1,
    trackTimeMillis: 208643,
    country: "USA",
    currency: "USD",
    primaryGenreName: "Rock",
    isStreamable: true,
  );

  final tMusicModelList = <MusicModel>[tMusicModel];
  final tMusicList = <Music>[tMusic];

  group('Get music list', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMusicList())
          .thenAnswer((_) async => tMusicModelList);
      // act
      final result = await repository.getMusicList();
      // assert
      verify(mockRemoteDataSource.getMusicList());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMusicList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMusicList()).thenThrow(ServerException());
      // act
      final result = await repository.getMusicList();
      // assert
      verify(mockRemoteDataSource.getMusicList());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getMusicList())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getMusicList();
      // assert
      verify(mockRemoteDataSource.getMusicList());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });


  group('Seach music', () {
    const tQuery = 'avril';

    test('should return music list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMusic(tQuery))
          .thenAnswer((_) async => tMusicModelList);
      // act
      final result = await repository.searchMusic(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMusicList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMusic(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMusic(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMusic(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMusic(tQuery);
      // assert
      expect(
          result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
