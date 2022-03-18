import 'package:dartz/dartz.dart';
import 'package:fita_music_app/common/failure.dart';
import 'package:fita_music_app/common/state_enum.dart';
import 'package:fita_music_app/domain/entities/music.dart';
import 'package:fita_music_app/domain/usecase/get_music_list.dart';
import 'package:fita_music_app/presentation/provider/music_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'music_list_notifier_test.mocks.dart';


@GenerateMocks([GetMusicList])
void main() {
  late MockGetMusicList mockMusicList;
  late MusicListNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockMusicList = MockGetMusicList();
    notifier = MusicListNotifier(getMusicList: mockMusicList)
      ..addListener(() {
        listenerCallCount++;
      });
  });



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

  final tMusicList = <Music>[tMusic];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockMusicList.execute())
        .thenAnswer((_) async => Right(tMusicList));
    // act
    notifier.fetchMusicList();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change music data when data is gotten successfully', () async {
    // arrange
    when(mockMusicList.execute())
        .thenAnswer((_) async => Right(tMusicList));
    // act
    await notifier.fetchMusicList();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.musicList, tMusicList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockMusicList.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchMusicList();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
